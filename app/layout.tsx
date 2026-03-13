import { Metadata } from 'next'
import { NextAuthProvider } from './providers'
import './app.css'

export const metadata: Metadata = {
  title: 'Second Brain - 第二大脑',
  description: '你的个人知识管理系统',
}

export const dynamic = 'force-dynamic'

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="zh">
      <body>
        <NextAuthProvider>{children}</NextAuthProvider>
      </body>
    </html>
  )
}
