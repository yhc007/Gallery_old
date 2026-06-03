package com.gallery.common;

import lombok.Data;

@Data
public class MenuTreeVo {
    String text;
    Integer wi;
    String align;
    Integer lmrgn;

    public MenuTreeVo(String text, int wi, String align, int lmrgn) {
        this.text = text;
        this.wi = wi;
        this.align = align;
        this.lmrgn = lmrgn;
    }
}
