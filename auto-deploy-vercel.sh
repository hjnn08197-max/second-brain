#!/bin/bash

# 自动部署到Vercel的智能脚本
# 支持多种部署方式

echo "🚀 Second Brain 自动部署到 Vercel"
echo "=================================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
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
    
    # 检查Node.js
    if ! command -v node &> /dev/null; then
        log_error "Node.js 未安装"
        exit 1
    fi
    
    # 检查npm
    if ! command -v npm &> /dev/null; then
        log_error "npm 未安装"
        exit 1
    fi
    
    # 检查Git
    if ! command -v git &> /dev/null; then
        log_error "Git 未安装"
        exit 1
    fi
    
    log_success "所有依赖检查通过"
}

# 检查Vercel CLI
check_vercel_cli() {
    log_info "检查 Vercel CLI..."
    
    if ! command -v vercel &> /dev/null; then
        log_warning "Vercel CLI 未安装，正在安装..."
        npm i -g vercel
        
        if [ $? -eq 0 ]; then
            log_success "Vercel CLI 安装成功"
        else
            log_error "Vercel CLI 安装失败"
            return 1
        fi
    else
        log_success "Vercel CLI 已安装: $(vercel --version)"
    fi
}

# 检查Vercel登录状态
check_vercel_login() {
    log_info "检查 Vercel 登录状态..."
    
    if vercel whoami &> /dev/null; then
        log_success "已登录 Vercel: $(vercel whoami)"
        return 0
    else
        log_warning "未登录 Vercel"
        return 1
    fi
}

# 处理Vercel登录
handle_vercel_login() {
    log_info "处理 Vercel 登录..."
    
    echo ""
    echo "请选择登录方式："
    echo "1) 自动登录（推荐）"
    echo "2) 手动登录"
    echo "3) 跳过登录（使用Dashboard部署）"
    echo ""
    
    read -p "请输入选择 (1-3): " choice
    
    case $choice in
        1)
            log_info "尝试自动登录..."
            vercel login
            
            if [ $? -eq 0 ]; then
                log_success "自动登录成功"
                return 0
            else
                log_error "自动登录失败，请尝试手动登录"
                return 1
            fi
            ;;
        2)
            log_info "请手动完成以下步骤："
            echo "1. 访问: https://vercel.com/oauth"
            echo "2. 使用你的 GitHub 账户登录"
            echo "3. 授权 Vercel 访问你的仓库"
            echo "4. 完成后按 Enter 继续"
            read -p ""
            
            # 检查是否登录成功
            if vercel whoami &> /dev/null; then
                log_success "手动登录成功"
                return 0
            else
                log_error "登录失败，请重试"
                return 1
            fi
            ;;
        3)
            log_warning "跳过登录，将使用Dashboard部署"
            return 2
            ;;
        *)
            log_error "无效选择"
            return 1
            ;;
    esac
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

# 部署到Vercel
deploy_to_vercel() {
    log_info "开始部署到 Vercel..."
    
    # 设置环境变量
    export NEXTAUTH_URL="https://$(basename $(pwd))-git-main-$(git config user.name).vercel.app"
    export NEXTAUTH_SECRET="$(openssl rand -hex 32)"
    
    # 部署
    vercel --prod --yes
    
    if [ $? -eq 0 ]; then
        log_success "部署成功！"
        return 0
    else
        log_error "部署失败"
        return 1
    fi
}

# 显示部署结果
show_deployment_result() {
    log_info "获取部署结果..."
    
    # 获取部署URL
    DEPLOY_URL=$(vercel ls | grep -o 'https://[^ ]*' | head -1)
    
    if [ -n "$DEPLOY_URL" ]; then
        echo ""
        echo "🎉 部署成功！"
        echo "=================================="
        echo "📱 访问地址: $DEPLOY_URL"
        echo "🔐 登录信息:"
        echo "   邮箱: admin@example.com"
        echo "   密码: 123456"
        echo "⏱️  部署时间: $(date)"
        echo "=================================="
        
        # 保存部署信息
        echo "$DEPLOY_URL" > DEPLOYMENT_URL.txt
        echo "admin@example.com" > DEPLOYMENT_LOGIN.txt
        echo "123456" > DEPLOYMENT_PASSWORD.txt
        
        log_success "部署信息已保存"
    else
        log_error "无法获取部署URL"
    fi
}

# Dashboard部署指南
show_dashboard_guide() {
    echo ""
    echo "📋 Vercel Dashboard 部署指南"
    echo "=================================="
    echo "1. 访问 Vercel Dashboard:"
    echo "   https://vercel.com/dashboard"
    echo ""
    echo "2. 点击 'New Project'"
    echo ""
    echo "3. 选择 'Import Git Repository'"
    echo ""
    echo "4. 选择 'hjnn08197-max/second-brain' 仓库"
    echo ""
    echo "5. 配置项目:"
    echo "   - Framework: Next.js"
    echo "   - Build Command: npm run build"
    echo "   - Install Command: npm install"
    echo ""
    echo "6. 设置环境变量:"
    echo "   NEXTAUTH_URL=https://your-app.vercel.app"
    echo "   NEXTAUTH_SECRET=your-secret-key-change-in-production"
    echo ""
    echo "7. 点击 'Deploy'"
    echo ""
    echo "8. 等待构建完成（2-5分钟）"
    echo ""
    echo "9. 访问部署的网站"
    echo "=================================="
}

# 主函数
main() {
    echo "🚀 Second Brain 自动部署脚本"
    echo "=================================="
    
    # 检查依赖
    check_dependencies
    
    # 检查Vercel CLI
    check_vercel_cli
    
    # 检查登录状态
    if ! check_vercel_login; then
        # 处理登录
        handle_vercel_login
        
        case $? in
            0)
                # 登录成功，继续部署
                ;;
            2)
                # 跳过登录，显示Dashboard指南
                show_dashboard_guide
                exit 0
                ;;
            *)
                # 登录失败，显示Dashboard指南
                log_error "登录失败，请使用Dashboard部署"
                show_dashboard_guide
                exit 1
                ;;
        esac
    fi
    
    # 拉取最新代码
    pull_latest_code
    
    # 安装依赖
    install_dependencies
    
    # 部署到Vercel
    deploy_to_vercel
    
    if [ $? -eq 0 ]; then
        # 显示部署结果
        show_deployment_result
        
        echo ""
        echo "🎉 部署完成！"
        echo "=================================="
        echo "📱 你的网站已部署成功！"
        echo "🔐 使用以下信息登录:"
        echo "   邮箱: admin@example.com"
        echo "   密码: 123456"
        echo "=================================="
    else
        log_error "部署失败"
        exit 1
    fi
}

# 运行主函数
main "$@"