import React from 'react';
import {BrowserRouter as Router, Route, Switch} from 'react-router-dom'
import Home from '../components/Home.jsx';

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home} />
    </Switch>
  </Router>
)
