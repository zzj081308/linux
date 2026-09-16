package com.example.demo.controller;

import com.example.demo.dto.NoteRequest;
import com.example.demo.entity.Note;
import com.example.demo.repository.NoteRepository;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

/**
 * 留言板接口，数据存 MySQL
 */
@RestController
@RequestMapping("/api/notes")
public class NoteController {

    private final NoteRepository noteRepository;

    public NoteController(NoteRepository noteRepository) {
        this.noteRepository = noteRepository;
    }

    /** 查询全部留言（最新在前） */
    @GetMapping
    public List<Note> list() {
        return noteRepository.findAllByOrderByIdDesc();
    }

    /** 新增留言 */
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Note create(@Valid @RequestBody NoteRequest request) {
        Note note = new Note();
        note.setContent(request.content().trim());
        return noteRepository.save(note);
    }

    /** 删除留言 */
    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable Long id) {
        noteRepository.deleteById(id);
        return Map.of("success", true, "message", "删除成功");
    }
}
