#!/bin/bash

# 自动部署脚本
cd /root/.openclaw/workspace/second-brain

echo "第二大脑项目部署脚本"
echo "=================="

# 检查必要文件
echo "检查项目文件..."
if [ ! -f "package.json" ] || [ ! -f "app/page.tsx" ]; then
    echo "❌ 项目文件不完整"
    exit 1
fi

# 清理
echo "清理旧文件..."
rm -rf .next 2>/dev/null || true
rm -rf dist 2>/dev/null || true

# 生成随机密钥
echo "生成环境变量..."
NEXTAUTH_SECRET=$(openssl rand -base64 32)
cat > .env.production << EOF
NEXTAUTH_URL=https://your-app.vercel.app
NEXTAUTH_SECRET=$NEXTAUTH_SECRET
EOF

echo "✅ 环境变量已生成"
echo "NEXTAUTH_SECRET: $NEXTAUTH_SECRET"

# 准备部署包
echo "准备部署文件..."
tar -czf second-brain-deploy.tar.gz \
    package.json \
    package-lock.json \
    app/ \
    next-env.d.ts \
    tsconfig.json \
    SPEC.md \
    .env.production

echo "✅ 部署包已创建: second-brain-deploy.tar.gz"

echo ""
echo "=== 部署步骤 ==="
echo "1. 访问 https://vercel.com/"
echo "2. 点击 'New Project'"
echo "3. 选择 'Import Git Repository'"
echo "4. 上传 second-brain-deploy.tar.gz"
echo "5. 设置环境变量："
echo "   - NEXTAUTH_URL: https://your-app.vercel.app"
echo "   - NEXTAUTH_SECRET: $NEXTAUTH_SECRET"
echo "6. 部署!"
echo ""
echo "=== 登录信息 ==="
echo "邮箱: admin@example.com"
echo "密码: 123456"