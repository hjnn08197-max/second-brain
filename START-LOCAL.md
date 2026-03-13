# 🚀 本地运行指南

## ✅ 当前状态
- **服务器状态**: ✅ 运行中
- **端口**: 3000
- **访问地址**: http://localhost:3000
- **技术栈**: Next.js 14.2 + React 18 + NextAuth

## 📱 访问方式
### 本地访问
```bash
# 直接访问
http://localhost:3000

# 或者指定IP访问
http://127.0.0.1:3000
```

### 网络访问（如果需要）
```bash
# 如果要从其他设备访问，确保服务器监听所有接口
export HOST=0.0.0.0
npm run dev
```

## 🔐 登录信息
根据 `.env.local` 配置：
- **邮箱**: admin@example.com
- **密码**: 123456

## 🛠️ 启动脚本

### 快速启动
```bash
cd /root/.openclaw/workspace/second-brain
./start.sh
```

### 指定端口启动
```bash
cd /root/.openclaw/workspace/second-brain
export HOST=0.0.0.0
export PORT=3001
npm run dev
```

### 停止服务器
```bash
pkill -f "next-server"
```

## 📊 应用信息
- **应用名称**: Second Brain - 第二大脑
- **描述**: 你的个人知识管理系统
- **版本**: 0.1.0
- **框架**: Next.js App Router

## 🔧 开发命令
```bash
# 开发模式
npm run dev

# 构建生产版本
npm run build

# 启动生产服务器
npm run start
```

## 🌐 功能特性
- 用户认证（NextAuth）
- 响应式设计
- 多语言支持（中文）
- 现代化UI界面

---
*最后更新: 2026-03-13 10:23:00*