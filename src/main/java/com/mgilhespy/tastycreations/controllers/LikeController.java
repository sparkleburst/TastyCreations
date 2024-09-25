package com.mgilhespy.tastycreations.controllers;

import com.mgilhespy.tastycreations.models.User;
import com.mgilhespy.tastycreations.services.LikeService;
import com.mgilhespy.tastycreations.services.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/likes")
public class LikeController {

    private static final Logger logger = LoggerFactory.getLogger(LikeController.class);

    @Autowired
    private LikeService likeService;

    @Autowired
    private UserService userService;

    // Handle the like button action
    @PostMapping("/recipes/{recipeId}/like")
    public String addLike(@PathVariable double recipeId, @RequestParam Long likerId) {
        logger.info("Received like request for recipeId: {} by userId: {}", recipeId, likerId);

        if (likeService.hasUserLikedRecipe(recipeId, likerId)) {
            logger.warn("User {} has already liked recipe {}", likerId, recipeId);
            return "redirect:/recipes/" + recipeId + "/information?error=alreadyLiked";
        }

        User liker = userService.findUserById(likerId);
        if (liker == null) {
            logger.error("User with ID {} not found", likerId);
            return "redirect:/recipes/" + recipeId + "?error=userNotFound";
        }

        likeService.addLike(recipeId, likerId);
        logger.info("Successfully added like for recipeId: {} by userId: {}", recipeId, likerId);
        return "redirect:/recipes/" + recipeId + "/information";
    }

    // Handle the unlike button action
    @PostMapping("/recipes/{recipeId}/unlike")
    public String removeLike(@PathVariable double recipeId, @RequestParam Long likerId) {
        logger.info("Received unlike request for recipeId: {} by userId: {}", recipeId, likerId);

        if (!likeService.hasUserLikedRecipe(recipeId, likerId)) {
            logger.warn("User {} has not liked recipe {}", likerId, recipeId);
            return "redirect:/recipes/" + recipeId + "/information?error=notLiked";
        }

        likeService.removeLike(recipeId, likerId);
        logger.info("Successfully removed like for recipeId: {} by userId: {}", recipeId, likerId);
        return "redirect:/recipes/" + recipeId + "/information";
    }
}
