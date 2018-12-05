import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {HttpClientModule} from '@angular/common/http';

import {AppComponent} from './app.component';
import {TeamPresentersComponent} from './team-presenters/team-presenters.component';

const appRoutes: Routes = [
  {path: 'presenters', component: TeamPresentersComponent},
];

@NgModule({
  declarations: [
    AppComponent,
    TeamPresentersComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,

    RouterModule.forRoot(appRoutes)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
