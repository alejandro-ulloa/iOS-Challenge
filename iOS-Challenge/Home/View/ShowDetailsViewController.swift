//
//  ShowDetailsViewController.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-06.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxDataSources

final class ShowDetailsViewController: BaseViewController, BindableType {
    
    var viewModel: ShowDetailsViewModel!
    
    let scrollView = UIScrollView()
    let mainStackView = UIStackView()
    
    let topStackView = UIStackView()
    let showImageView = UIImageView()
    let detailStackView = UIStackView()
    let genresStackView = UIStackView()
    let genresTitleLabel = UILabel()
    let genresLabel = UILabel()
    let scheduleStackView = UIStackView()
    let scheduleTitleLabel = UILabel()
    let timeTitleLabel = UILabel()
    let timeLabel = UILabel()
    let daysTitleLabel = UILabel()
    let daysLabel = UILabel()
    
    let summaryLabel = UILabel()
    
    let  episodesTableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteTapped))
        loadFavorite()
    }
    
    @objc func favoriteTapped() {
        UserDefaultsManager.shared.toggleFavorites(id: "\(viewModel.show.id ?? 0)")
        loadFavorite()
    }
    
    func loadFavorite() {
        self.navigationItem.rightBarButtonItem?.image = UserDefaultsManager.shared.getFavorites().contains(where: { $0 == "\(viewModel.show.id ?? 0)" }) ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    func setUpViews() {
        view.addSubview(scrollView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        scrollView.addSubview(mainStackView)
        
        topStackView.axis = .horizontal
        topStackView.distribution = .fillEqually
        topStackView.alignment = .top
        topStackView.spacing = 10
        mainStackView.addArrangedSubview(topStackView)
        
        showImageView.contentMode = .scaleAspectFit
        topStackView.addArrangedSubview(showImageView)
        
        detailStackView.axis = .vertical
        detailStackView.distribution = .fillProportionally
        detailStackView.alignment = .fill
        detailStackView.spacing = 15
        topStackView.addArrangedSubview(detailStackView)
        
        genresStackView.axis = .vertical
        genresStackView.distribution = .fillProportionally
        genresStackView.alignment = .fill
        genresStackView.spacing = 5
        detailStackView.addArrangedSubview(genresStackView)
        
        genresTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        genresTitleLabel.textAlignment = .center
        genresStackView.addArrangedSubview(genresTitleLabel)
        
        genresLabel.numberOfLines = 0
        genresLabel.font = .systemFont(ofSize: 12)
        genresStackView.addArrangedSubview(genresLabel)
        
        scheduleStackView.axis = .vertical
        scheduleStackView.distribution = .fillProportionally
        scheduleStackView.alignment = .fill
        scheduleStackView.spacing = 5
        detailStackView.addArrangedSubview(scheduleStackView)
        
        scheduleTitleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        scheduleTitleLabel.textAlignment = .center
        scheduleStackView.addArrangedSubview(scheduleTitleLabel)
        
        timeTitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        scheduleStackView.addArrangedSubview(timeTitleLabel)
        
        timeLabel.numberOfLines = 0
        timeLabel.font = .systemFont(ofSize: 12)
        scheduleStackView.addArrangedSubview(timeLabel)
        
        daysTitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        scheduleStackView.addArrangedSubview(daysTitleLabel)
        
        daysLabel.font = .systemFont(ofSize: 12)
        scheduleStackView.addArrangedSubview(daysLabel)
        
        summaryLabel.numberOfLines = 0
        summaryLabel.textAlignment = .justified
        summaryLabel.font = .systemFont(ofSize: 12)
        mainStackView.addArrangedSubview(summaryLabel)
        
        episodesTableView.rx.observe(CGSize.self, "contentSize")
            .subscribe(onNext: { [episodesTableView] size in
                episodesTableView.snp.updateConstraints { $0.height.equalTo(size?.height ?? 0) }
            })
            .disposed(by: disposeBag)
        episodesTableView.rowHeight = 40
        episodesTableView.isScrollEnabled = false
        episodesTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
        mainStackView.addArrangedSubview(episodesTableView)
        
    }
    
    func setUpLabels() {
        navigationItem.title = viewModel.show.name
        if let imageURLString = viewModel.show.image?.original, let imageURL = URL(string: imageURLString) {
            showImageView.kf.setImage(with: imageURL)
        }
        genresTitleLabel.text = "genre_label".localized
        genresLabel.text = viewModel.show.genres?.joined(separator: ", ")
        scheduleTitleLabel.text = "schedule_label".localized
        timeTitleLabel.text = "time_label".localized
        timeLabel.text = viewModel.show.schedule?.time
        daysTitleLabel.text = "days_label".localized
        daysLabel.text = viewModel.show.schedule?.days?.joined(separator: ", ")
        summaryLabel.text = viewModel.show.summary?.htmlTransform()
    }
    
    func setUpConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 15, bottom: 0, right: 15))
            $0.width.equalTo(view)
            $0.centerX.equalTo(view)
        }
        
        topStackView.snp.makeConstraints {
            $0.width.equalTo(mainStackView)
            $0.height.equalTo(view).multipliedBy(0.35)
        }
        
        genresTitleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        scheduleTitleLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        summaryLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
        
        episodesTableView.snp.makeConstraints {
            $0.width.equalToSuperview()
        }
    }
    
    func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Episode>>(
            configureCell: { (_, table, indexPath, element) in
                if let cell = table.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier) as? EpisodeTableViewCell {
                    cell.setUp(episode: element)
                    return cell
                }
                return UITableViewCell()
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        
        viewModel
            .episodesSubject
            .map({ [weak self] episodes -> [SectionModel<String, Episode>] in
                var model: [SectionModel<String, Episode>] = []
                
                self?.viewModel.seasons.forEach { season in
                    model.append(SectionModel(model: "Season \(season)", items: episodes.filter { $0.season == season }))
                }
                return model
            })
            .bind(to: episodesTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        episodesTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if let cell = self.episodesTableView.cellForRow(at: indexPath) as? EpisodeTableViewCell {
                    self.viewModel.goToEpisodeDetailsAction.execute(cell.episode)
                }
            }).disposed(by: disposeBag)
    }
}

