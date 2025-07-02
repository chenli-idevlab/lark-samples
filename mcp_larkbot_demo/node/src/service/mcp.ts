/**
 * MCP客户端服务
 * MCP Client Service
 *
 * 功能说明:
 * - 创建和管理MCP(Model Context Protocol)客户端
 * - 连接飞书MCP服务器
 * - 提供工具调用功能
 *
 * Features:
 * - Create and manage MCP (Model Context Protocol) clients
 * - Connect to Lark MCP server
 * - Provide tool calling functionality
 */

import { experimental_createMCPClient as createMCPClient } from 'ai';
// @ts-ignore - 忽略类型检查，因为这是实验性功能
// @ts-ignore - Ignore type checking as this is experimental feature
import { Experimental_StdioMCPTransport as StdioMCPTransport } from 'ai/mcp-stdio';
import { config } from '../config';

/**
 * MCP客户端服务类
 * MCP Client Service Class
 * 提供创建和管理MCP客户端的静态方法
 * Provides static methods for creating and managing MCP clients
 */
export class MCPClientService {
  /**
   * 创建飞书MCP客户端
   * Create Lark MCP client
   *
   * 该方法通过启动外部进程来创建MCP客户端连接
   * This method creates MCP client connection by starting external process
   *
   * @param accessToken 用户访问令牌（可选）/ User access token (optional)
   * @returns Promise<MCPClient> MCP客户端实例 / MCP client instance
   */
  static async createLarkMCPClient(accessToken?: string) {
    // 构建命令参数
    // Build command arguments
    const command = 'npx';
    const args = ['-y', '@larksuiteoapi/lark-mcp', 'mcp', '-a', config.lark.appId, '-s', config.lark.appSecret];

    // 如果提供了用户访问令牌，添加到参数中
    // If user access token is provided, add it to arguments
    if (accessToken) {
      args.push('-u', accessToken);
    }

    // 创建并返回MCP客户端，使用标准输入输出传输
    // Create and return MCP client using stdio transport
    return createMCPClient({ transport: new StdioMCPTransport({ command, args }) });
  }
}
