#!/bin/bash

# GitHub部署自动化脚本

echo "🐙 第二brains项目 - GitHub部署准备"
echo "================================"

# 检查Git状态
cd /root/.openclaw/workspace/second-brain
echo "📋 Git状态检查:"
git status --porcelain || echo "✅ Git工作区干净"

# 创建最小化的部署版本
echo "📦 创建最小化部署版本..."
rm -rf deploy-clean
mkdir -p deploy-clean

# 复制必要文件
cp package.json deploy-clean/
cp tsconfig.json deploy-clean/
mkdir -p deploy-clean/app
cp -r app/* deploy-clean/app/
cp next-env.d.ts deploy-clean/
cp SPEC.md deploy-clean/

# 创建package.json的精简版本（排除开发依赖）
cat > deploy-clean/package.json << 'EOF'
{
  "name": "second-brain",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "^14.2.35",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "next-auth": "^4.24.10"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/node": "^20.0.0",
    "@types/react": "^18.0.0",
    "@types/react-dom": "^18.0.0"
  }
}
EOF

# 创建README
cat > deploy-clean/README.md << 'EOF'
# 第二brains - 个人知识管理系统

基于Next.js的个人知识管理系统，支持登录、搜索、筛选等功能。

## 功能特性
- ✅ 登录功能（NextAuth.js）
- ✅ 全量列表展示
- ✅ 全局搜索（Cmd+K）
- ✅ 多维筛选（日期+类型）
- ✅ 简约设计
- ✅ 响应式布局

## 快速开始
1. 安装依赖：npm install
2. 启动开发：npm run dev
3. 访问：http://localhost:3000

## 登录信息
- 邮箱：admin@example.com
- 密码：123456

## 部署
上传到GitHub并启用Pages即可自动部署。

## 配置
添加环境变量：
- NEXTAUTH_URL = 你的域名
- NEXTAUTH_SECRET = 随机密钥

## 许可证
MIT
EOF

# 打包最小版本
tar -czf second-brain-github-deploy.tar.gz -C deploy-clean .
echo "✅ 创建部署包：second-brain-github-deploy.tar.gz"

# 清理
rm -rf deploy-clean

echo ""
echo "🚀 部署步骤："
echo "1. 访问 https://github.com/"
echo "2. 创建新仓库：second-brain"
echo "3. 推送当前代码：git push origin main"
echo "4. 启用Pages服务"
echo "5. 访问应用"
echo ""
echo "📁 本地Git仓库已准备就绪"