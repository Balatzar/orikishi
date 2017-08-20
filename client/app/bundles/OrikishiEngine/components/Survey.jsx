import React, { Component } from "react";
import ReactOnRails from "react-on-rails";
import ReactSurvey from "react-survey";

const csrfToken = ReactOnRails.authenticityToken();

class Survey extends Component {
  constructor(props) {
    super(props);
    console.log(props);
  }

  render() {
    return (
      <div className="Survey">
        <ReactSurvey
          data={Object.assign({}, this.props.survey, this.props, { csrfToken })}
        />
      </div>
    );
  }
}

export default Survey;
