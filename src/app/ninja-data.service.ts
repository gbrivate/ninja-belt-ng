import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
    providedIn: 'root'
  }
)
export class NinjaDataService {

  constructor(private http: HttpClient) {

  }

  retrieveTeams(): any {
    return this.http.get('/assets/teams.json');
  }
}
