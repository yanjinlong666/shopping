package com.fh.shop.backend.mapper.image;

import com.fh.shop.backend.po.image.Images;

import java.util.List;

public interface IImageMapper {
    void addImages(List<Images> imagesList);

    List<Images> findImagesByProductId(Integer productId);

    void delOldPath(List<Integer> delImgIdsList);

    List<Images> findImageByImageIds(List<Integer> idsList);
}
