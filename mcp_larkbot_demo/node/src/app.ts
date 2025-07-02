/**
 * 应用程序主入口文件
 * Main application entry point
 *
 * 功能说明:
 * - 初始化Express服务器
 * - 注册聊天提供者(飞书/Lark)
 * - 配置路由和中间件
 * - 启动HTTP服务
 *
 * Features:
 * - Initialize Express server
 * - Register chat providers (Lark)
 * - Configure routes and middleware
 * - Start HTTP service
 */

import express from 'express';
import { config } from './config';
import { ChatController } from './controller/chat';
import { LarkChatProvider, LarkWebhookChatProvider } from './provider/lark';
import path from 'path';

const mode = process.argv[2];
console.log('Run With Mode:', mode);
// 初始化
// Initialize
// 对于 Lark 用户，建议使用 LarkWebhookChatProvider，WebSocket不支持Lark，使用 Webhook 开发中可能需要内网穿透
// For Lark user please use LarkWebhookChatProvider, websocket is not supported，using webhook may need a tunnel in development
// const providers = [new LarkWebhookChatProvider()];
const providers = [mode === 'webhook' ? new LarkWebhookChatProvider() : new LarkChatProvider()];
const chatController = new ChatController(providers);
const app = express();

// 配置静态文件服务，用于提供认证页面等静态资源
// Configure static file service for auth pages and other static resources
app.use(express.static(path.join(__dirname, '../public')));

// 注册聊天控制器的路由和事件监听器
// Register chat controller routes and event listeners
chatController.register(app);

// 启动HTTP服务器并监听指定端口
// Start HTTP server and listen on specified port
app.listen(config.port, () => {
  console.log(`🚀 服务器运行在 http://localhost:${config.port}`);
  console.log(`🚀 Server running at http://localhost:${config.port}`);
});
