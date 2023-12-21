package com.hntrip.root.file.controller;

import java.io.File;
import java.io.FileInputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hntrip.root.file.service.FileService;

@Controller
@RequestMapping("board")
public class FileController {
	@GetMapping("download")
	public void download(@RequestParam String fileName,
			HttpServletResponse response) throws Exception {
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		File file = new File(FileService.IMAGE_REPO+"/"+fileName);
		FileInputStream fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, response.getOutputStream());
	}
}
