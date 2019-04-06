package com.fh.shop.backend.biz.image;

import com.fh.shop.backend.mapper.image.IImageMapper;
import com.fh.shop.backend.po.image.Images;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class IImageServiceImpl implements IImageService {
    @Autowired
    private IImageMapper iImageMapper;

    @Override
    public void addImages(List<Images> imagesList) {
        iImageMapper.addImages(imagesList);
    }

    @Override
    public List<Images> findImagesByProductId(Integer productId) {
        return iImageMapper.findImagesByProductId(productId);
    }

    @Override
    public void delOldPath(String delImgIds) {
        String[] delImgIdsArr = delImgIds.split(",");
        List<Integer> delImgIdsList = new ArrayList<>();
        for (int i =0;i<delImgIdsArr.length;i++){
            delImgIdsList.add(Integer.parseInt(delImgIdsArr[i]));
        }
        iImageMapper.delOldPath(delImgIdsList);
    }

    @Override
    public List<Images> findImageByImageIds(List<Integer> idsList) {
        return iImageMapper.findImageByImageIds(idsList);
    }
}
