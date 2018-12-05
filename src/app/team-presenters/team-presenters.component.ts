import { Component, OnInit } from '@angular/core';

import { NinjaDataService } from '../ninja-data.service';

@Component({
  selector: 'app-team-presenters',
  templateUrl: './team-presenters.component.html',
  styleUrls: ['./team-presenters.component.css']
})
export class TeamPresentersComponent implements OnInit {

  ninjaTeams: any[];

  constructor(private dataService: NinjaDataService) {
  }

  ngOnInit() {
    this.dataService.retrieveTeams()
      .subscribe(data => {
        this.ninjaTeams = data.teams.filter(team => team.isOwner);
      });
  }
}
