package com.gallery.board;

import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.sql.Timestamp;

@Data
@Alias("boardVo")
public class BoardVo {

    int number;
    String type;
    String writer;
    String writer_type;
    String title;
    String content;
    int priority;
    Timestamp uploadTime;

}
