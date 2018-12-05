import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TeamPresentersComponent } from './team-presenters.component';

describe('TeamPresentersComponent', () => {
  let component: TeamPresentersComponent;
  let fixture: ComponentFixture<TeamPresentersComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TeamPresentersComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TeamPresentersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
