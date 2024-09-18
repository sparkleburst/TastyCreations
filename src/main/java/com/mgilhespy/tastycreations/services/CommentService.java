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

    public List<Comment> getALLComments(Long reviewId) {
        return commentRepository.findAllByCommenterId(reviewId);
    }
    public Comment updateComment(Comment comment) {
        Comment updatedComment = commentRepository.findById(comment.getId()).get();
        updatedComment.setContent(comment.getContent());
        updatedComment.setCommenter(comment.getCommenter());
        updatedComment.setReview(comment.getReview());
        return commentRepository.save(updatedComment);
    }



}
