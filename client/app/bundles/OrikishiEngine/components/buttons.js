import React from "react";

const ContinueButton = props => {
  return (
    <button
      title="Select this path of the story and see what the people (if any) have created. Don't worry you can go back."
      className="or-button or-button-continue"
      onClick={props.onClick}
    >
      <i className="icon icon-check" />
      Continue
    </button>
  );
};

const GoBackButton = props => {
  return (
    <button
      title="Go back to this frame in the story."
      className="or-button or-button-goBack"
      onClick={props.onClick}
    >
      <i className="icon icon-control-rewind" />
      Go back
    </button>
  );
};

const CreateButton = props => {
  return (
    <button
      title="Opens a dialog that allows you to create a follow-up to this frame!"
      className="or-button or-button-create"
      onClick={props.onClick}
    >
      <i className="icon icon-plus" />
      Create
    </button>
  );
};

export { ContinueButton, GoBackButton, CreateButton };
