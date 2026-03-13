import { NextRequest, NextResponse } from 'next/server'

// 企业微信聊天记录接口
export async function GET(request: NextRequest) {
  try {
    // 从环境变量获取企业微信配置
    const corpid = process.env.WECOM_CORPID
    const corpsecret = process.env.WECOM_CORPSECRET
    const agentid = process.env.WECOM_AGENTID

    // 检查必要的环境变量
    if (!corpid || !corpsecret || !agentid) {
      return NextResponse.json(
        { error: '缺少企业微信配置信息' },
        { status: 400 }
      )
    }

    // 1. 获取access_token
    const tokenResponse = await fetch(
      `https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=${corpid}&corpsecret=${corpsecret}`
    )
    
    if (!tokenResponse.ok) {
      return NextResponse.json(
        { error: '获取access_token失败' },
        { status: 500 }
      )
    }

    const tokenData = await tokenResponse.json()
    const accessToken = tokenData.access_token

    if (!accessToken) {
      return NextResponse.json(
        { error: '获取access_token失败' },
        { status: 500 }
      )
    }

    // 2. 获取外部联系人聊天记录（示例API，实际需要根据企业微信API文档调整）
    // 注意：企业微信API需要特定权限，实际使用时需要在企业微信管理后台配置
    const chatResponse = await fetch(
      `https://qyapi.weixin.qq.com/cgi-bin/externalcontact/groupchat/list?access_token=${accessToken}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ limit: 100 })
      }
    )

    if (!chatResponse.ok) {
      return NextResponse.json(
        { error: '获取聊天记录失败' },
        { status: 500 }
      )
    }

    const chatData = await chatResponse.json()

    // 3. 处理聊天记录数据，转换为第二大脑的Memory格式
    const formattedChats = chatData.group_chat_list?.map((chat: any) => ({
      id: chat.chat_id || `wecom_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`,
      title: chat.name || '未命名群聊',
      content: `群聊: ${chat.name || '未命名群聊'}\n成员数: ${chat.member_count || 0}\n创建时间: ${new Date().toISOString().split('T')[0]}`,
      type: 'conversation' as const,
      tags: ['企业微信', '聊天记录'],
      createdAt: new Date().toISOString().split('T')[0],
      updatedAt: new Date().toISOString().split('T')[0]
    })) || []

    // 4. 返回格式化后的聊天记录
    return NextResponse.json(formattedChats)
  } catch (error) {
    console.error('企业微信聊天记录获取失败:', error)
    return NextResponse.json(
      { error: '获取企业微信聊天记录失败' },
      { status: 500 }
    )
  }
}
