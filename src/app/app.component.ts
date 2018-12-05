import {Component, OnInit} from '@angular/core';

import 'rxjs';

import {NinjaGroupService} from './ninja-group.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {

  title = 'ninha-belt-ng';

  ninjaTeams: any[];

  constructor(private ninjaGroupService: NinjaGroupService) {
    this.ninjaTeams = [];
  }

  ngOnInit(): void {
    this.ninjaGroupService.retrieveGroups()
      .subscribe(data => {
        this.ninjaTeams = data.teams.filter(team => team.isOwner);
      });
  }

  private retrieveGroups(): void {

  }
}
