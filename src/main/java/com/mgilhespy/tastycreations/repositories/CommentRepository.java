package com.mgilhespy.tastycreations.repositories;

import com.mgilhespy.tastycreations.models.Comment;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends CrudRepository<Comment, Long> {
    List<Comment> findAllByCommenterId(Long id);
}
