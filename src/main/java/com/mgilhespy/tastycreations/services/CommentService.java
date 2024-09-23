package com.mgilhespy.tastycreations.services;

import com.mgilhespy.tastycreations.models.Comment;
import com.mgilhespy.tastycreations.repositories.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    // Get all comments by commenterId (you may want to rename this depending on your logic)
    public List<Comment> getALLComments(Long commenterId) {
        return commentRepository.findAllByCommenterId(commenterId);
    }

    // Update comment logic
    public Comment updateComment(Comment comment) {
        Comment updatedComment = commentRepository.findById(comment.getId()).get();
        updatedComment.setContent(comment.getContent());
        updatedComment.setCommenter(comment.getCommenter());
        return commentRepository.save(updatedComment);
    }
}
