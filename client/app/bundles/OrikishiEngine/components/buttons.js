import React from "react";

const ContinueButton = props => {
  return (
    <button className="or-button or-button-continue" onClick={props.onClick}>
      Continue
    </button>
  );
};

const GoBackButton = props => {
  return (
    <button className="or-button or-button-goBack" onClick={props.onClick}>
      Go back
    </button>
  );
};

const CreateButton = props => {
  return (
    <button className="or-button or-button-create" onClick={props.onClick}>
      Create
    </button>
  );
};

export { ContinueButton, GoBackButton, CreateButton };
