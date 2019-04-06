package com.fh.shop.backend.biz.image;

import com.fh.shop.backend.po.image.Images;

import java.util.List;

public interface IImageService {
    void addImages(List<Images> imagesList);

    List<Images> findImagesByProductId(Integer productId);

    void delOldPath(String delImgIds);

    List<Images> findImageByImageIds(List<Integer> idsList);
}
