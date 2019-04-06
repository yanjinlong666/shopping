package com.fh.shop.backend.controller;

import com.fh.core.common.ServiceResponse;
import com.fh.core.util.COSUtil;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/upload")
public class UploadController extends BaseController{

    @RequestMapping("/uploadFile")
    public ServiceResponse uploadFile(@RequestParam MultipartFile uploadFile) throws IOException {
        if (uploadFile.getSize()>0){
            String imgPath = COSUtil.uploadFile(uploadFile.getInputStream(),uploadFile.getOriginalFilename());
            return ServiceResponse.success(imgPath);
        }
        return ServiceResponse.error();
    }
}
