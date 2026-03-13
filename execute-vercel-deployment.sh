#!/bin/bash

# 执行Vercel部署的完整脚本
# 包含本地准备和Vercel部署指南

echo "🚀 Second Brain 完整部署执行脚本"
echo "=================================="

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
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

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    log_info "检查依赖..."
    
    if ! command -v node &> /dev/null; then
        log_error "Node.js 未安装"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        log_error "npm 未安装"
        exit 1
    fi
    
    if ! command -v git &> /dev/null; then
        log_error "Git 未安装"
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
        log_error "代码拉取失败"
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
        log_error "依赖安装失败"
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
        log_error "项目构建失败"
        return 1
    fi
}

# 显示Vercel部署指南
show_vercel_deployment_guide() {
    echo ""
    echo "📋 Vercel Dashboard 完整部署指南"
    echo "=================================="
    echo ""
    echo "🌐 第一步：访问 Vercel Dashboard"
    echo "   https://vercel.com/dashboard"
    echo ""
    echo "📝 第二步：创建新项目"
    echo "   1. 点击 'New Project'"
    echo "   2. 选择 'Import Git Repository'"
    echo "   3. 选择 'hjnn08197-max/second-brain' 仓库"
    echo ""
    echo "⚙️  第三步：配置项目"
    echo "   Framework: Next.js（自动检测）"
    echo "   Build Command: npm run build"
    echo "   Install Command: npm install"
    echo "   Output Directory: .next"
    echo ""
    echo "🔑 第四步：设置环境变量"
    echo "   NEXTAUTH_URL=https://your-app.vercel.app"
    echo "   NEXTAUTH_SECRET=your-secret-key-change-in-production"
    echo ""
    echo "🚀 第五步：开始部署"
    echo "   1. 点击 'Deploy'"
    echo "   2. 等待构建完成（2-5分钟）"
    echo "   3. 查看部署状态"
    echo ""
    echo "🌐 第六步：访问网站"
    echo "   部署完成后访问: https://second-brain-git-main-hjnn08197-max.vercel.app"
    echo ""
    echo "🔐 第七步：测试登录"
    echo "   邮箱: admin@example.com"
    echo "   密码: 123456"
    echo "=================================="
}

# 显示自动化部署选项
show_deployment_options() {
    echo ""
    echo "🎯 选择部署方式："
    echo ""
    echo "1) 手动部署（推荐）"
    echo "   - 通过Vercel Dashboard操作"
    echo "   - 最简单可靠的方式"
    echo ""
    echo "2) 自动化部署（需要Vercel CLI）"
    echo "   - 使用 vercel 命令"
    echo "   - 需要先登录Vercel"
    echo ""
    echo "3) 查看详细文档"
    echo "   - 查看完整的部署指南"
    echo ""
    
    read -p "请输入选择 (1-3): " choice
    
    case $choice in
        1)
            log_info "选择手动部署方式"
            show_vercel_deployment_guide
            ;;
        2)
            log_info "选择自动化部署方式"
            echo ""
            echo "🚀 自动化部署步骤："
            echo "1. 确保已安装 Vercel CLI"
            echo "2. 登录 Vercel: vercel login"
            echo "3. 部署项目: vercel"
            echo "4. 按照提示完成配置"
            echo ""
            echo "💡 如果需要帮助，请查看 VERCEL-DEPLOYMENT-GUIDE.md"
            ;;
        3)
            log_info "查看详细文档"
            echo ""
            echo "📚 文档列表："
            echo "- VERCEL-DEPLOYMENT-GUIDE.md: 完整部署指南"
            echo "- AUTO-DEPLOY-SYSTEM.md: 自动化部署系统"
            echo "- DEPLOYMENT-STATUS.md: 部署状态报告"
            ;;
        *)
            log_error "无效选择，默认显示手动部署指南"
            show_vercel_deployment_guide
            ;;
    esac
}

# 主函数
main() {
    echo "🚀 Second Brain 完整部署执行脚本"
    echo "=================================="
    echo ""
    
    # 检查依赖
    check_dependencies
    
    # 拉取最新代码
    pull_latest_code
    
    # 安装依赖
    install_dependencies
    
    # 构建项目
    build_project
    
    echo ""
    echo "✅ 本地环境准备完成！"
    echo "=================================="
    echo ""
    
    # 显示部署选项
    show_deployment_options
    
    echo ""
    echo "🎉 部署准备完成！"
    echo "=================================="
    echo "💡 提示："
    echo "- 项目已准备就绪，可以直接导入到 Vercel"
    echo "- 如果遇到问题，请查看相关文档"
    echo "- 部署完成后即可访问你的网站"
    echo "=================================="
}

# 运行主函数
main "$@"