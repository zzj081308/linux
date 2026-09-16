package com.example.demo.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/**
 * 新增留言的请求体
 */
public record NoteRequest(
        @NotBlank(message = "留言内容不能为空")
        @Size(max = 500, message = "留言内容不能超过 500 字")
        String content
) {
}
