package net.biancheng.campusspringboot.controller;

import net.biancheng.campusspringboot.entity.*;
import net.biancheng.campusspringboot.service.CampusService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class CampusController {

    @Autowired
    private CampusService campusService;

    @GetMapping("/home")
    public ResponseEntity<Map<String, Object>> getHomePageData() {
        Map<String, Object> data = campusService.getAllHomePageData();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", data);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getStats() {
        List<CampusStats> stats = campusService.getAllStats();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", stats);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/academic-programs")
    public ResponseEntity<Map<String, Object>> getAcademicPrograms() {
        List<AcademicPrograms> programs = campusService.getAllAcademicPrograms();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", programs);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/campus-life")
    public ResponseEntity<Map<String, Object>> getCampusLifeFeatures() {
        List<CampusLifeFeatures> features = campusService.getAllCampusLifeFeatures();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", features);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/news")
    public ResponseEntity<Map<String, Object>> getNews() {
        List<News> news = campusService.getAllNews();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", news);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/news/{id}")
    public ResponseEntity<Map<String, Object>> getNewsById(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        campusService.getNewsById(id).ifPresentOrElse(
            news -> {
                response.put("success", true);
                response.put("data", news);
            },
            () -> {
                response.put("success", false);
                response.put("message", "新闻未找到");
            }
        );
        return ResponseEntity.ok(response);
    }

    @GetMapping("/nav-links")
    public ResponseEntity<Map<String, Object>> getNavLinks() {
        List<NavLinks> links = campusService.getAllNavLinks();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", links);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/footer-links")
    public ResponseEntity<Map<String, Object>> getFooterLinks() {
        Map<String, Object> links = campusService.getFooterLinksGrouped();
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("data", links);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/school-info")
    public ResponseEntity<Map<String, Object>> getSchoolInfo() {
        Map<String, Object> response = new HashMap<>();
        campusService.getSchoolInfo().ifPresentOrElse(
            info -> {
                response.put("success", true);
                response.put("data", info);
            },
            () -> {
                response.put("success", false);
                response.put("message", "学校信息未找到");
            }
        );
        return ResponseEntity.ok(response);
    }
}