import React, { Component } from "react";
import ReactOnRails from "react-on-rails";
import request from "superagent";
import { SkyLightStateless } from "react-skylight";

const csrfToken = ReactOnRails.authenticityToken();

class OrikishiEngine extends Component {
  constructor(props) {
    super(props);
    this.state = {
      ourStory: props.story,
      myStory: [],
      currentBranch: props.story.steps[0].frames[0].branches[0],
      modalOpen: false,
      currentFrame: 0,
      modalFrameFullscreen: false,
      modalFrameFullscreenImg: "",
      modalFrameFullscreenText: "",
    };

    this.closeModal = this.closeModal.bind(this);
    this.openModal = this.openModal.bind(this);
    this.setCurrentBranch = this.setCurrentBranch.bind(this);
    this.rewind = this.rewind.bind(this);
    this.addFollowUp = this.addFollowUp.bind(this);
    this.showFrameFullScreen = this.showFrameFullScreen.bind(this);
  }

  componentDidMount() {
    this.chooseBranch(this.state.currentBranch);
  }

  closeModal() {
    this.setState({ modalOpen: false });
  }

  openModal(currentFrame) {
    this.setState({
      modalOpen: true,
      currentFrame,
    });
  }

  setCurrentBranch(newCurrentBranch) {
    this.setState({
      currentBranch: newCurrentBranch,
    });
    this.chooseBranch(newCurrentBranch);
  }

  chooseBranch(newBranch) {
    const myStory = this.state.myStory;
    const ourStory = this.state.ourStory.steps;
    if (myStory.length) {
      const lastStep = myStory.pop();
      myStory.push([lastStep.find(f => f.branches.includes(newBranch))]);
    }
    for (let i = myStory.length, end = ourStory.length; i < end; i += 1) {
      const currentFrames = ourStory[i].frames;
      const framesToAdd = currentFrames.filter(f =>
        f.branches.includes(newBranch)
      );
      if (!framesToAdd.length) {
        break;
      }
      newBranch = framesToAdd[0].branches[1] || framesToAdd[0].branches[0];
      myStory.push(framesToAdd);
      if (framesToAdd.length > 1) {
        break;
      }
    }
    this.setState({ myStory, currentBranch: newBranch });
  }

  rewind(newBranch, frame) {
    console.log("REWIND");
    const { myStory, ourStory } = this.state;
    let nextStep;

    for (let i = 0, end = myStory.length; i < end; i += 1) {
      if (myStory[i].find(f => f.id === frame.id)) {
        myStory.splice(i + 1);
        this.setState({ myStory });
        this.chooseBranch(newBranch);
        break;
      }
    }
  }

  addFollowUp(text, image, frameComponent) {
    if (!text || !image || !frameComponent) {
      return;
    }
    request
      .post(this.props.add_follow_up_path)
      .send({
        frame: this.state.currentFrame,
        newFrame: { text, image },
        authenticity_token: csrfToken,
      })
      .end((err, res) => {
        if (err) {
          console.warn(err);
        } else {
          const body = res.body;
          console.log(body);
          frameComponent.refs.textInput.value = "";
          this.setState({ modalOpen: false });
          this.insertFollowUpIntoMyStory(body.new_frame, body.old_frame_id);
        }
      });
  }

  insertFollowUpIntoMyStory(newFrame, oldFrameId) {
    console.log(this.state);
    const myStory = this.state.myStory;
    let oldFrame, nextStep, isLastStep, branch;

    for (let i = 0, end = myStory.length; i < end; i += 1) {
      oldFrame = myStory[i].find(f => f.id === oldFrameId);
      if (oldFrame) {
        branch =
          oldFrame.branches.length > 1
            ? oldFrame.branches[1]
            : oldFrame.branches[0];
        myStory.splice(i);
        myStory.push([oldFrame]);
        if (this.state.ourStory.steps[i + 1]) {
          nextStep = this.state.ourStory.steps[i + 1].frames.filter(f =>
            f.branches.includes(branch)
          );
          nextStep.push(newFrame);
        } else {
          nextStep = [newFrame];
        }
        myStory.push(nextStep);
        break;
      }
    }

    this.setState({
      myStory,
      currentBranch: branch,
    });
    console.log(this.state);
  }

  showFrameFullScreen(url, text) {
    this.setState({
      modalFrameFullscreen: true,
      modalFrameFullscreenImg: url,
      modalFrameFullscreenText: text,
    });
  }

  modalFrameFullscreenStyles = {};

  render() {
    console.log(this.state);
    return (
      <div className="App">
        <div className="Engine">
          <SkyLightStateless
            dialogStyles={this.modalFrameFullscreenStyles}
            isVisible={this.state.modalFrameFullscreen}
            onOverlayClicked={() => {
              this.setState({ modalFrameFullscreen: false });
            }}
            onCloseClicked={() => {
              this.setState({ modalFrameFullscreen: false });
            }}
          >
            <img
              className="img-fullscreen"
              src={this.state.modalFrameFullscreenImg}
            />
            <p>{this.state.modalFrameFullscreenText}</p>
          </SkyLightStateless>
          <Story
            story={this.state.myStory}
            name={this.state.ourStory.name}
            currentBranch={this.state.currentBranch}
            modalOpen={this.state.modalOpen}
            closeModal={this.closeModal}
            openModal={this.openModal}
            setCurrentBranch={this.setCurrentBranch}
            rewind={this.rewind}
            addFollowUp={this.addFollowUp}
            showFrameFullScreen={this.showFrameFullScreen}
          />
        </div>
      </div>
    );
  }
}

class Story extends Component {
  constructor(props) {
    super(props);
    this.state = {
      imagePreviewUrl: "",
      fileName: "",
      image: "",
    };
    this.handleImageChange = this.handleImageChange.bind(this);
  }

  handleImageChange(event) {
    let reader = new FileReader();
    let file = event.target.files[0];

    reader.onloadend = () => {
      this.setState({
        imagePreviewUrl: reader.result,
        image: reader.result,
      });
    };

    reader.readAsDataURL(file);
  }

  render() {
    const steps = this.props.story.map((s, i) => (
      <Step
        step={s}
        key={i}
        currentBranch={this.props.currentBranch}
        setCurrentBranch={this.props.setCurrentBranch}
        openModal={this.props.openModal}
        last={i === this.props.story.length - 1}
        rewind={this.props.rewind}
        addFollowUp={this.props.addFollowUp}
        showFrameFullScreen={this.props.showFrameFullScreen}
      />
    ));
    return (
      <div className="Story">
        <h2>Orikishi</h2>
        <SkyLightStateless
          isVisible={this.props.modalOpen}
          onOverlayClicked={() => {
            this.props.closeModal();
          }}
          onCloseClicked={() => {
            this.props.closeModal();
          }}
          title="Continue the story"
        >
          <h4>{this.state.file ? this.state.file.name : ""}</h4>
          <img
            className="img-preview"
            src={this.state.imagePreviewUrl}
            alt=""
          />
          <form
            onSubmit={event => {
              event.preventDefault();
              this.props.addFollowUp(
                this.refs.textInput.value,
                this.state.image,
                this
              );
            }}
          >
            <textarea
              ref="textInput"
              type="text"
              placeholder="Your caption/commentary/joke here (optional)"
            />
            <input
              type="file"
              placeholder="Choose an image file"
              onChange={this.handleImageChange}
            />
            <button type="submit">Creer</button>
          </form>
        </SkyLightStateless>
        <h3>{this.props.name}</h3>
        {steps}
      </div>
    );
  }
}

class Step extends Component {
  render() {
    const frames = this.props.step.map((f, i) => (
      <Frame
        frame={f}
        key={i}
        currentBranch={this.props.currentBranch}
        openModal={this.props.openModal}
        addFollowUp={this.props.addFollowUp}
        showFrameFullScreen={this.props.showFrameFullScreen}
        last={this.props.last}
        choice={this.props.step.length > 1}
        onClick={
          this.props.last ? this.props.setCurrentBranch : this.props.rewind
        }
      />
    ));

    return <div className="Step">{frames}</div>;
  }
}

class Frame extends Component {
  render() {
    const frame = this.props.frame;
    const branch = frame.branches[1] || frame.branches[0];
    const { last, choice } = this.props;
    let text;

    return (
      <div className="Frame">
        <div
          onClick={() => this.props.showFrameFullScreen(frame.url, frame.text)}
        >
          <img src={frame.url} alt="" />
          <p>{frame.text}</p>
        </div>
        {last && !choice ? null : (
          <button onClick={() => this.props.onClick(branch, frame)}>
            {last ? "Continue" : "Go back"}
          </button>
        )}
        {choice ? null : (
          <button onClick={() => this.props.openModal(frame.id)}>Create</button>
        )}
      </div>
    );
  }
}

export default OrikishiEngine;
