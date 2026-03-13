#!/bin/bash

# 自动部署到Vercel的简化脚本
# 直接使用Dashboard部署方式

echo "🚀 Second Brain 自动部署到 Vercel"
echo "=================================="

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# 检查依赖
check_dependencies() {
    log_info "检查依赖..."
    
    if ! command -v node &> /dev/null; then
        echo "❌ Node.js 未安装"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        echo "❌ npm 未安装"
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        echo "❌ Git 未安装"
        exit 1
    fi
    
    log_success "所有依赖检查通过"
}

# 拉取最新代码
pull_latest_code() {
    log_info "拉取最新代码..."
    
    git pull origin main
    
    if [ $? -eq 0 ]; then
        log_success "代码拉取成功"
        return 0
    else
        echo "❌ 代码拉取失败"
        return 1
    fi
}

# 安装依赖
install_dependencies() {
    log_info "安装项目依赖..."
    
    npm install
    
    if [ $? -eq 0 ]; then
        log_success "依赖安装成功"
        return 0
    else
        echo "❌ 依赖安装失败"
        return 1
    fi
}

# 构建项目
build_project() {
    log_info "构建项目..."
    
    npm run build
    
    if [ $? -eq 0 ]; then
        log_success "项目构建成功"
        return 0
    else
        echo "❌ 项目构建失败"
        return 1
    fi
}

# 显示部署指南
show_deployment_guide() {
    echo ""
    echo "📋 Vercel Dashboard 部署指南"
    echo "=================================="
    echo "🌐 访问 Vercel Dashboard:"
    echo "   https://vercel.com/dashboard"
    echo ""
    echo "📝 部署步骤:"
    echo "1. 点击 'New Project'"
    echo "2. 选择 'Import Git Repository'"
    echo "3. 选择 'hjnn08197-max/second-brain' 仓库"
    echo "4. 配置项目:"
    echo "   - Framework: Next.js"
    echo "   - Build Command: npm run build"
    echo "   - Install Command: npm install"
    echo ""
    echo "5. 设置环境变量:"
    echo "   NEXTAUTH_URL=https://your-app.vercel.app"
    echo "   NEXTAUTH_SECRET=your-secret-key-change-in-production"
    echo ""
    echo "6. 点击 'Deploy'"
    echo "7. 等待构建完成（2-5分钟）"
    echo "8. 访问部署的网站"
    echo ""
    echo "🔐 登录信息:"
    echo "   邮箱: admin@example.com"
    echo "   密码: 123456"
    echo "=================================="
}

# 主函数
main() {
    echo "🚀 Second Brain 自动部署脚本"
    echo "=================================="
    
    # 检查依赖
    check_dependencies
    
    # 拉取最新代码
    pull_latest_code
    
    # 安装依赖
    install_dependencies
    
    # 构建项目
    build_project
    
    echo ""
    echo "✅ 本地准备完成！"
    echo "=================================="
    echo "🚀 现在请按照以下步骤部署到 Vercel:"
    echo ""
    
    # 显示部署指南
    show_deployment_guide
    
    echo ""
    echo "💡 提示:"
    echo "- 如果已经配置了 Vercel CLI，可以运行: vercel"
    echo "- 如果需要帮助，请查看 VERCEL-DEPLOYMENT-GUIDE.md"
    echo "- 项目已准备就绪，可以直接导入到 Vercel"
    echo "=================================="
}

# 运行主函数
main "$@"