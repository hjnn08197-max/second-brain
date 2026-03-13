#!/bin/bash

# 第二大脑 - 一键部署脚本
echo "🚀 第二大脑部署选项"
echo "=================="

echo ""
echo "选择部署方式:"
echo "1) Vercel部署 (推荐)"
echo "2) Netlify部署" 
echo "3) GitHub Pages"
echo "4) DigitalOcean App Platform"
echo "5) 手动下载部署包自行部署"
echo ""

read -p "请选择 (1-5): " choice

case $choice in
    1)
        echo "🌟 Vercel部署 (推荐)"
        echo "=================="
        echo "步骤:"
        echo "1. 访问 https://vercel.com/"
        echo "2. 注册/登录账户"
        echo "3. 点击 'New Project'"
        echo "4. 选择 'Import Git Repository'"
        echo "5. 选择/创建新的Git仓库，上传 second-brain-deploy.tar.gz"
        echo "6. 设置环境变量:"
        echo "   NEXTAUTH_URL = https://your-app.vercel.app"
        echo "   NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI="
        echo "7. 点击Deploy"
        echo ""
        echo "📝 注意: 你需要GitHub账户"
        ;;
    2)
        echo "🌐 Netlify部署"
        echo "=============="
        echo "步骤:"
        echo "1. 访问 https://netlify.com/"
        echo "2. 注册/登录"
        echo "3. 选择 'New site from Git'"
        echo "4. 连接GitHub账户"
        echo "5. 选择项目，上传 second-brain-deploy.tar.gz"
        echo "6. 在环境变量中设置:"
        echo "   NEXTAUTH_URL = https://your-app-name.netlify.app"
        echo "   NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI="
        echo "7. 点击Deploy"
        ;;
    3)
        echo "🐙 GitHub Pages"
        echo "==============="
        echo "步骤:"
        echo "1. 创建GitHub仓库: second-brain"
        echo "2. 上传 second-brain-deploy.tar.gz 到仓库"
        echo "3. 在仓库设置中启用GitHub Pages"
        echo "4. 配置域名和环境变量"
        ;;
    4)
        echo "☁️ DigitalOcean App Platform"
        echo "========================="
        echo "步骤:"
        echo "1. 访问 https://cloud.digitalocean.com/"
        echo "2. 创建新App"
        echo "3. 选择静态站点"
        echo "4. 上传second-brain-deploy.tar.gz"
        echo "5. 配置环境变量"
        ;;
    5)
        echo "📦 手动部署"
        echo "=========="
        echo "部署包已准备好: second-brain-deploy.tar.gz"
        echo ""
        echo "上传这个文件到你的选中的部署平台"
        echo "登录信息:"
        echo "邮箱: admin@example.com"
        echo "密码: 123456"
        ;;
    *)
        echo "❌ 无效选择"
        exit 1
        ;;
esac

echo ""
echo "🎯 环境变量信息:"
echo "NEXTAUTH_URL = 你的应用域名"
echo "NEXTAUTH_SECRET = ycfMvbaRmBdIp8d2ScdgIDLIrV8/I8BL+JXmoMSKVlI="
echo ""
echo "📋 项目功能:"
echo "✅ 登录功能"
echo "✅ 全量列表展示"
echo "✅ 全局搜索 (Cmd+K)"
echo "✅ 多维筛选 (日期/类型)"
echo "✅ 简约设计"
echo "✅ 响应式布局"
echo ""
echo "🔐 安全说明:"
echo "- 演示账号密码简单，部署后建议修改"
echo "- 生产环境建议使用数据库验证用户"