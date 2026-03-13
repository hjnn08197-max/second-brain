#!/bin/bash

# Vercel 一键部署脚本
echo "🚀 开始部署到 Vercel..."

# 检查Vercel CLI是否安装
if ! command -v vercel &> /dev/null; then
    echo "❌ Vercel CLI 未安装，正在安装..."
    npm i -g vercel
fi

# 检查是否已登录
if ! vercel whoami &> /dev/null; then
    echo "🔐 需要登录 Vercel..."
    echo "请访问以下链接完成OAuth认证："
    echo "https://vercel.com/oauth"
    echo ""
    echo "或者手动通过Vercel Dashboard部署："
    echo "1. 访问 https://vercel.com/dashboard"
    echo "2. 点击 'New Project'"
    echo "3. 选择 'Import Git Repository'"
    echo "4. 选择 'hjnn08197-max/second-brain'"
    echo "5. 点击 'Deploy'"
    echo ""
    read -p "按 Enter 继续（或按 Ctrl+C 取消）..."
fi

# 拉取最新代码
echo "📥 拉取最新代码..."
git pull origin main

# 部署到Vercel
echo "🚀 部署到 Vercel..."
vercel --prod

echo "✅ 部署完成！"
echo "📱 访问地址: $(vercel ls | grep -o 'https://[^ ]*' | head -1)"