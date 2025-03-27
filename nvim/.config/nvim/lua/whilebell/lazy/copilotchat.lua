return {
    -- Copilot setup
    {
        "zbirenbaum/copilot.lua",
        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,          -- Enable suggestion feature
                    auto_trigger = true,     -- Automatically trigger suggestions as you type
                    debounce = 75,           -- Debounce time in milliseconds (adjust if suggestions feel too slow or fast)
                    keymap = {
                        accept = "<Tab>",    -- Key to accept the suggestion (Tab)
                        accept_word = false, -- Set to a key if you want to accept a single word
                        accept_line = false, -- Set to a key if you want to accept a single line
                    },
                },
                filetypes = {
                    ["*"] = true, -- Enable Copilot for all filetypes by default
                },
            })
        end,
    },

    -- CopilotChat setup
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "zbirenbaum/copilot.lua",                       -- Copilot integration
            { "nvim-lua/plenary.nvim", branch = "master" }, -- Utilities for curl, log and async functions
        },
        build = "make tiktoken",                            -- Required for token counting on MacOS/Linux

        opts = function()
            -- Define common prompts for code operations
            local prompts = {
                Explain = {
                    prompt =
                    'Explain this code in clear, concise language. Include its purpose, how it works, and any important patterns or techniques used.',
                    system_prompt = 'COPILOT_EXPLAIN',
                },
                Review = {
                    prompt =
                    'Review this code for bugs, edge cases, performance issues, and best practice violations. Suggest specific improvements.',
                    system_prompt = 'COPILOT_REVIEW',
                },
                Fix = {
                    prompt =
                    'Identify and fix all bugs and issues in this code. Explain each problem found, why it\'s problematic, and how your solution resolves it.',
                },
                Optimize = {
                    prompt =
                    'Optimize this code for better performance, readability and maintainability. Explain your optimization strategy, the specific changes made, and quantify improvements where possible.',
                },
                Docs = {
                    prompt =
                    'Add comprehensive documentation comments to this code following best practices for this language. Include function/method purpose, parameters, return values, and usage examples where appropriate.',
                },
                Tests = {
                    prompt =
                    'Generate thorough unit tests for this code covering normal cases, edge cases, and potential failure scenarios. Use appropriate testing frameworks and best practices for this language.',
                },
                Commit = {
                    prompt =
                    'Write a clear, concise commit message for these changes following the commitizen convention. Keep the title under 50 characters, use imperative mood, and wrap body text at 72 characters. Format as a gitcommit code block.',
                    context = 'git:staged',
                },
                Refactor = {
                    prompt =
                    'Refactor this code to improve its structure without changing functionality. Focus on reducing complexity, improving readability, and applying design patterns where appropriate. Explain your refactoring decisions.',
                },
                Complexity = {
                    prompt =
                    'Analyze the time and space complexity of this code. Identify performance bottlenecks and suggest optimizations with their expected complexity improvements.',
                },
                Debug = {
                    prompt =
                    'Help debug this code. Identify potential issues, suggest debugging strategies, and recommend fixes for common problems that might cause the observed behavior.',
                },
                Implement = {
                    prompt =
                    'Implement the functionality described in the comments or function signatures. Provide a complete, well-structured solution following best practices for this language.',
                },
                TypeCheck = {
                    prompt =
                    'Add proper type annotations/declarations to this code following language best practices. Explain any complex type decisions and ensure type safety throughout.',
                },
            }

            return {
                model = 'claude-3.7-sonnet', -- Default model (can be specified with $ in prompt)
                window = {
                    layout = 'float', -- 'vertical', 'horizontal', 'float', 'replace'
                    width = 0.6, -- fractional width when < 1, absolute columns when > 1
                    height = 0.6, -- fractional height when < 1, absolute rows when > 1
                    title = "󱀢", -- Window title
                    border = "single", -- Window border style
                },
                prompts = prompts, -- Use our defined prompts
                debug = false, -- Set to true to see debug logs
                show_help = true, -- Show help text when opening chat
                show_system_prompt = false, -- Show system prompt in chat
                close_on_done = false, -- Keep window open when request completes
                auto_follow_cursor = false, -- Auto-update context based on cursor position
                language_code = "en", -- Response language (translate to preferred language if needed)
                error_sign = "⚠️",
                warning_sign = "⚠️",
                scroll_to_bottom = true, -- Auto-scroll to bottom on response

                question_header = ' User ', -- Header to use for user questions
                answer_header = ' Copilot ', -- Header to use for AI answers
                error_header = ' Error ', -- Header to use for errors
            }
        end,

        -- Keybindings grouped by functionality
        keys = {
            -- General chat
            { "<leader>zc", ":CopilotChat<CR>",           mode = { "n", "v" }, desc = "Chat with Copilot" },

            -- Code operations
            { "<leader>ze", ":CopilotChatExplain<CR>",    mode = "v",          desc = "Explain Code" },
            { "<leader>zr", ":CopilotChatReview<CR>",     mode = "v",          desc = "Review Code" },
            { "<leader>zf", ":CopilotChatFix<CR>",        mode = "v",          desc = "Fix Code Issues" },
            { "<leader>zo", ":CopilotChatOptimize<CR>",   mode = "v",          desc = "Optimize Code" },
            { "<leader>zd", ":CopilotChatDocs<CR>",       mode = "v",          desc = "Generate Docs" },
            { "<leader>zt", ":CopilotChatTests<CR>",      mode = "v",          desc = "Generate Tests" },
            { "<leader>za", ":CopilotChatRefactor<CR>",   mode = "v",          desc = "Refactor Code" },
            { "<leader>zx", ":CopilotChatComplexity<CR>", mode = "v",          desc = "Analyze Complexity" },
            { "<leader>zg", ":CopilotChatDebug<CR>",      mode = "v",          desc = "Debug Help" },
            { "<leader>zi", ":CopilotChatImplement<CR>",  mode = "v",          desc = "Implement Functionality" },
            { "<leader>zy", ":CopilotChatTypeCheck<CR>",  mode = "v",          desc = "Add Type Annotations" },

            -- Git operations
            { "<leader>zm", ":CopilotChatCommit<CR>",     mode = "n",          desc = "Generate Commit Message" },
            { "<leader>zs", ":CopilotChatCommit<CR>",     mode = "v",          desc = "Generate Commit for Selection" },
        },
    },
}
