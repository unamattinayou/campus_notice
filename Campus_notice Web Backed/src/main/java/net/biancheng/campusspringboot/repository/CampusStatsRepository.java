package net.biancheng.campusspringboot.repository;

import net.biancheng.campusspringboot.entity.CampusStats;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CampusStatsRepository extends JpaRepository<CampusStats, Long> {
    List<CampusStats> findAllByOrderByIdAsc();
}