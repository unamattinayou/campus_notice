package net.biancheng.campusspringboot.service;

import net.biancheng.campusspringboot.entity.*;
import net.biancheng.campusspringboot.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class CampusService {

    @Autowired
    private CampusStatsRepository campusStatsRepository;

    @Autowired
    private AcademicProgramsRepository academicProgramsRepository;

    @Autowired
    private CampusLifeFeaturesRepository campusLifeFeaturesRepository;

    @Autowired
    private NewsRepository newsRepository;

    @Autowired
    private NavLinksRepository navLinksRepository;

    @Autowired
    private FooterLinksRepository footerLinksRepository;

    @Autowired
    private SchoolInfoRepository schoolInfoRepository;

    public List<CampusStats> getAllStats() {
        return campusStatsRepository.findAllByOrderByIdAsc();
    }

    public List<AcademicPrograms> getAllAcademicPrograms() {
        return academicProgramsRepository.findAllByOrderByIdAsc();
    }

    public List<CampusLifeFeatures> getAllCampusLifeFeatures() {
        return campusLifeFeaturesRepository.findAllByOrderByIdAsc();
    }

    public List<News> getAllNews() {
        return newsRepository.findAllPublishedOrderByTopAndPublishDateDesc();
    }

    public Page<News> getNewsPage(int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        return newsRepository.findAllPublishedOrderByTopAndPublishDateDesc(pageable);
    }

    public Page<News> getNewsPageByCategory(String category, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        return newsRepository.findByCategoryPublished(category, pageable);
    }

    public Page<News> searchNews(String keyword, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        return newsRepository.searchByKeyword(keyword, pageable);
    }

    public Page<News> searchNewsByCategory(String keyword, String category, int page, int size) {
        Pageable pageable = PageRequest.of(page - 1, size);
        return newsRepository.searchByKeywordAndCategory(keyword, category, pageable);
    }

    public Optional<News> getNewsById(Long id) {
        return newsRepository.findById(id);
    }

    public List<NavLinks> getAllNavLinks() {
        return navLinksRepository.findAllByOrderBySortOrderAsc();
    }

    public List<FooterLinks> getAllFooterLinks() {
        return footerLinksRepository.findAllByOrderBySectionAscSortOrderAsc();
    }

    public Map<String, Object> getFooterLinksGrouped() {
        List<FooterLinks> links = getAllFooterLinks();
        Map<String, Object> grouped = new HashMap<>();
        for (FooterLinks link : links) {
            grouped.computeIfAbsent(link.getSection(), k -> new java.util.ArrayList<>());
            ((List<FooterLinks>) grouped.get(link.getSection())).add(link);
        }
        return grouped;
    }

    public Optional<SchoolInfo> getSchoolInfo() {
        return schoolInfoRepository.findFirstByIdNotNull();
    }

    public Map<String, Object> getAllHomePageData() {
        Map<String, Object> data = new HashMap<>();
        data.put("stats", getAllStats());
        data.put("academicPrograms", getAllAcademicPrograms());
        data.put("campusLifeFeatures", getAllCampusLifeFeatures());
        data.put("news", getAllNews());
        data.put("navLinks", getAllNavLinks());
        data.put("footerLinks", getFooterLinksGrouped());
        data.put("schoolInfo", getSchoolInfo().orElse(null));
        return data;
    }
}