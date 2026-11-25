package com.example.demo.repository;

import com.example.demo.entity.Note;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NoteRepository extends JpaRepository<Note, Long> {

    /** 按 id 倒序查全部（最新的留言在最前面） */
    List<Note> findAllByOrderByIdDesc();
}
