import {HttpClient} from '@angular/common/http';
import {Injectable, Type} from "@angular/core";

import 'rxjs';

@Injectable({
    providedIn: 'root'
  }
)
export class NinjaGroupService {

  constructor(private http: HttpClient) {

  }

  retrieveGroups(): any {
    return this.http.get('/assets/teams.json');
  }
}
