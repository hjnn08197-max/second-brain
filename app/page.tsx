'use client'

import { useSession, signIn, signOut } from 'next-auth/react'
import { useState, useEffect, useMemo } from 'react'

// 类型定义
interface Memory {
  id: string
  title: string
  content: string
  type: 'note' | 'conversation' | 'memory'
  tags: string[]
  createdAt: string
  updatedAt: string
}

// 示例数据
const sampleData: Memory[] = [
  {
    id: '1',
    title: '2026年产品规划',
    content: '第一季度目标：完成核心功能开发，包括笔记管理、对话记录存储和全局搜索。第二季度：优化性能，提升用户体验。第三季度：推出移动端适配。第四季度：用户量突破10万。',
    type: 'note',
    tags: ['规划', '产品'],
    createdAt: '2026-01-15',
    updatedAt: '2026-01-15'
  },
  {
    id: '2',
    title: '与AI助手的对话 - 技术选型',
    content: '讨论了Next.js vs Remix的技术选型，最终决定使用Next.js App Router，因为它有更好的生态和稳定性。',
    type: 'conversation',
    tags: ['AI', '技术'],
    createdAt: '2026-02-20',
    updatedAt: '2026-02-20'
  },
  {
    id: '3',
    title: '阅读《深度工作》笔记',
    content: '核心观点：在当今充满干扰的世界，深度工作是一种稀缺能力。方法：1. 设定深度工作时间块 2. 远离社交媒体 3. 践行刻意练习。',
    type: 'memory',
    tags: ['阅读', '效率'],
    createdAt: '2026-03-01',
    updatedAt: '2026-03-01'
  },
  {
    id: '4',
    title: '下周会议要点',
    content: '1. 回顾上周进度 2. 讨论技术难题 3. 确认下周计划 4. 团队建设活动安排',
    type: 'note',
    tags: ['会议', '周会'],
    createdAt: '2026-03-05',
    updatedAt: '2026-03-05'
  },
  {
    id: '5',
    title: 'AI助手指南 - prompt技巧',
    content: '有效的prompt结构：1. 明确角色 2. 说明背景 3. 设定任务 4. 指定格式 5. 提供示例',
    type: 'memory',
    tags: ['AI', '技巧'],
    createdAt: '2026-03-08',
    updatedAt: '2026-03-08'
  },
  {
    id: '6',
    title: '代码审查反馈',
    content: '本次审查发现：1. 组件命名不规范 2. 缺少错误处理 3. 性能可以进一步优化。建议使用React Query进行数据缓存。',
    type: 'conversation',
    tags: ['代码', '审查'],
    createdAt: '2026-03-10',
    updatedAt: '2026-03-10'
  },
  {
    id: '7',
    title: '年度阅读计划',
    content: '2026年计划阅读：1. 《深度工作》2. 《思考，快与慢》3. 《人类简史》4. 《创新者的窘境》5. 《幂幂之道》',
    type: 'note',
    tags: ['阅读', '计划'],
    createdAt: '2026-01-03',
    updatedAt: '2026-01-03'
  },
  {
    id: '8',
    title: '难忘的对话 - 职业建议',
    content: '前辈建议：1. 专注核心竞争力 2. 保持好奇心 3. 建立个人品牌 4. 重视健康管理 5. 享受过程',
    type: 'conversation',
    tags: ['职业', '建议'],
    createdAt: '2026-02-14',
    updatedAt: '2026-02-14'
  },
  {
    id: '9',
    title: '灵光一现的想法',
    content: '做一个「第二大脑」应用，聚合所有笔记、对话和记忆碎片，用AI增强搜索和关联能力。',
    type: 'memory',
    tags: ['想法', '产品'],
    createdAt: '2026-01-20',
    updatedAt: '2026-01-20'
  },
  {
    id: '10',
    title: '学习React新特性',
    content: 'Server Components是React的重大革新。优点：1. 减少客户端JavaScript 2. 直接访问数据库 3. 自动代码分割。注意事项：需要理解服务端和客户端组件的边界。',
    type: 'memory',
    tags: ['学习', 'React'],
    createdAt: '2026-03-02',
    updatedAt: '2026-03-02'
  }
]

// 类型标签
const typeLabels = {
  note: '笔记',
  conversation: '对话',
  memory: '记忆'
}

const typeColors = {
  note: '#0066ff',
  conversation: '#00aa66',
  memory: '#ff9900'
}

function Loading() {
  return (
    <div className="loading-container">
      <div className="loading-spinner"></div>
      <p>加载中...</p>
    </div>
  )
}

export default function Home() {
  const { data: session, status } = useSession()
  const [memories, setMemories] = useState<Memory[]>(sampleData)
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedType, setSelectedType] = useState<string>('all')
  const [dateRange, setDateRange] = useState({ start: '', end: '' })
  const [showSearchModal, setShowSearchModal] = useState(false)
  const [modalSearch, setModalSearch] = useState('')
  const [selectedMemory, setSelectedMemory] = useState<Memory | null>(null)

  // 加载状态
  if (status === 'loading') {
    return <Loading />
  }

  // 未登录
  if (!session) {
    return (
      <div className="login-container">
        <div className="login-box">
          <h1>第二大脑</h1>
          <p>请先登录</p>
          <button onClick={() => signIn()}>登录</button>
        </div>
      </div>
    )
  }

  // 筛选逻辑
  const filteredMemories = useMemo(() => {
    if (!memories || memories.length === 0) return []
    return memories.filter(m => {
      if (!m) return false
      if (searchQuery) {
        const q = searchQuery.toLowerCase()
        if (!m.title?.toLowerCase().includes(q) && !m.content?.toLowerCase().includes(q)) {
          return false
        }
      }
      if (selectedType !== 'all' && m.type !== selectedType) return false
      if (dateRange.start && m.createdAt < dateRange.start) return false
      if (dateRange.end && m.createdAt > dateRange.end) return false
      return true
    })
  }, [memories, searchQuery, selectedType, dateRange])

  const modalResults = useMemo(() => {
    if (!modalSearch) return []
    if (!memories || memories.length === 0) return []
    const q = modalSearch.toLowerCase()
    return memories.filter(m => 
      m.title?.toLowerCase().includes(q) || m.content?.toLowerCase().includes(q)
    ).slice(0, 10)
  }, [memories, modalSearch])

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
        e.preventDefault()
        setShowSearchModal(true)
      }
      if (e.key === 'Escape') {
        setShowSearchModal(false)
        setSelectedMemory(null)
      }
    }
    window.addEventListener('keydown', handleKeyDown)
    return () => window.removeEventListener('keydown', handleKeyDown)
  }, [])

  const formatDate = (dateStr: string) => {
    if (!dateStr) return ''
    try {
      const d = new Date(dateStr)
      return `${d.getMonth() + 1}月${d.getDate()}日`
    } catch (error) {
      return dateStr
    }
  }

  return (
    <div className="container">
      <header className="header">
        <h1 className="title">第二大脑</h1>
        <div className="header-right">
          <button className="search-btn" onClick={() => setShowSearchModal(true)}>
            <span>搜索...</span>
            <kbd>⌘K</kbd>
          </button>
          <button className="logout-btn" onClick={() => signOut()}>退出</button>
        </div>
      </header>

      <main className="main">
        <aside className="sidebar">
          <div className="filter-group">
            <label>内容类型</label>
            <select value={selectedType} onChange={(e) => setSelectedType(e.target.value)}>
              <option value="all">全部</option>
              <option value="note">笔记</option>
              <option value="conversation">对话</option>
              <option value="memory">记忆</option>
            </select>
          </div>
          
          <div className="filter-group">
            <label>开始日期</label>
            <input type="date" value={dateRange.start}
              onChange={(e) => setDateRange({...dateRange, start: e.target.value})} />
          </div>
          
          <div className="filter-group">
            <label>结束日期</label>
            <input type="date" value={dateRange.end}
              onChange={(e) => setDateRange({...dateRange, end: e.target.value})} />
          </div>

          <div className="filter-group">
            <label>快速搜索</label>
            <input type="text" placeholder="搜索标题或内容..." value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)} />
          </div>

          <div className="stats">
            <span>共 {filteredMemories.length} 条</span>
          </div>
        </aside>

        <section className="content">
          {filteredMemories.length === 0 ? (
            <div className="empty">
              <p>没有找到相关内容</p>
              <button onClick={() => {
                setSearchQuery('')
                setSelectedType('all')
                setDateRange({ start: '', end: '' })
              }}>清除筛选</button>
            </div>
          ) : (
            <div className="card-list">
              {filteredMemories.map(m => {
                if (!m) return null
                return (
                  <div key={m.id} className="card" onClick={() => setSelectedMemory(m)}>
                    <div className="card-header">
                      <span className="type-tag" style={{ color: typeColors[m.type] }}>
                        {typeLabels[m.type]}
                      </span>
                      <span className="date">{formatDate(m.createdAt)}</span>
                    </div>
                    <h3 className="card-title">{m.title}</h3>
                    <p className="card-content">{m.content}</p>
                    <div className="card-tags">
                      {m.tags?.map(tag => (
                        <span key={tag} className="tag">{tag}</span>
                      ))}
                    </div>
                  </div>
                )
              })}
            </div>
          )}
        </section>
      </main>

      {showSearchModal && (
        <div className="modal-overlay" onClick={() => setShowSearchModal(false)}>
          <div className="modal" onClick={e => e.stopPropagation()}>
            <input type="text" className="modal-input" placeholder="搜索所有内容..."
              value={modalSearch} onChange={(e) => setModalSearch(e.target.value)} autoFocus />
            <div className="modal-results">
              {modalSearch === '' && <p className="modal-hint">输入关键词开始搜索</p>}
              {modalResults.map(m => {
                if (!m) return null
                return (
                  <div key={m.id} className="modal-result" onClick={() => {
                    setSelectedMemory(m)
                    setShowSearchModal(false)
                    setModalSearch('')
                  }}>
                    <span className="type-tag" style={{ color: typeColors[m.type] }}>
                      {typeLabels[m.type]}
                    </span>
                    <span className="result-title">{m.title}</span>
                  </div>
                )
              })}
              {modalSearch && modalResults.length === 0 && <p className="modal-empty">未找到相关结果</p>}
            </div>
            <div className="modal-footer"><kbd>ESC</kbd> 关闭</div>
          </div>
        </div>
      )}

      {selectedMemory && (
        <div className="modal-overlay" onClick={() => setSelectedMemory(null)}>
          <div className="detail-modal" onClick={e => e.stopPropagation()}>
            <div className="detail-header">
              <span className="type-tag" style={{ color: typeColors[selectedMemory.type] }}>
                {typeLabels[selectedMemory.type]}
              </span>
              <span className="detail-date">{selectedMemory.createdAt}</span>
            </div>
            <h2 className="detail-title">{selectedMemory.title}</h2>
            <p className="detail-content">{selectedMemory.content}</p>
            <div className="detail-tags">
              {selectedMemory.tags?.map(tag => (
                <span key={tag} className="tag">{tag}</span>
              ))}
            </div>
            <button className="close-btn" onClick={() => setSelectedMemory(null)}>关闭</button>
          </div>
        </div>
      )}
    </div>
  )
}
