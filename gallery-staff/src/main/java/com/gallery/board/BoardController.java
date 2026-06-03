package com.gallery.board;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@RequestMapping("/board")
@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @RequestMapping(value = "getTitle.do")
    @ResponseBody
    public List<String> getBoardData(Model model) {
        try {
            return boardService.getTitles();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
