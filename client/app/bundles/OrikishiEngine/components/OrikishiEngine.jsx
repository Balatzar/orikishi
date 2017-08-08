import React, { Component } from 'react'
import ReactOnRails from 'react-on-rails';
import request from 'superagent'

const csrfToken = ReactOnRails.authenticityToken();

class OrikishiEngine extends Component {
  constructor(props) {
    super(props)
    this.state = {
      ourStory: props.story,
      myStory: [],
      currentBranch: 1,
    }

    this.setCurrentBranch = this.setCurrentBranch.bind(this)
    this.rewind = this.rewind.bind(this)
    this.addFollowUp = this.addFollowUp.bind(this)
  }

  componentDidMount() {
    this.chooseBranch(1)
  }

  setCurrentBranch(newCurrentBranch) {
    this.setState({
      currentBranch: newCurrentBranch,
    })
    this.chooseBranch(newCurrentBranch)
  }

  chooseBranch(newBranch) {
    const myStory = this.state.myStory
    const ourStory = this.state.ourStory.steps
    if (myStory.length) {
      const lastStep = myStory.pop()
      myStory.push([lastStep.find(f => f.branches.includes(newBranch))])
    }
    for (let i = myStory.length, end = ourStory.length; i < end; i += 1) {
      const currentFrames = ourStory[i].frames
      const framesToAdd = currentFrames.filter(f => f.branches.includes(newBranch))
      myStory.push(framesToAdd)
      if (framesToAdd.length > 1) {
        break
      }
    }
    this.setState({ myStory })
  }

  rewind(newBranch, frame) {
    const { myStory, ourStory } = this.state
    let nextStep
    
    for (let i = 0, end = myStory.length; i < end; i += 1) {
      if (myStory[i].find(f => f.id === frame.id)) {
        myStory.splice(i + 1)
        this.setState({ myStory })
        this.chooseBranch(newBranch)
        break
      }
    }
  }

  addFollowUp(frame, { text }, frameComponent) {
    event.preventDefault()
    request
    .post(this.props.add_follow_up_path)
    .send({ frame, text, authenticity_token: csrfToken })
    .end((err, { body }) => {
      if (err) {
        console.warn(err)
      } else {
        console.log(body)
        frameComponent.refs.textInput.value = ""
        this.insertFollowUpIntoMyStory(body.new_frame, body.old_frame_id)
      }
    })
  }

  insertFollowUpIntoMyStory(newFrame, oldFrameId) {
    console.log(this.state)
    const myStory = this.state.myStory
    let oldFrame, nextStep, isLastStep, branch
    
    for (let i = 0, end = myStory.length; i < end; i += 1) {
      oldFrame = myStory[i].find(f => f.id === oldFrameId)
      if (oldFrame) {
        branch = oldFrame.branches.length > 1 ? oldFrame.branches[1] : oldFrame.branches[0]
        myStory.splice(i)
        myStory.push([oldFrame])
        if (this.state.ourStory.steps[i + 1]) {
          nextStep = this.state.ourStory.steps[i + 1].frames.filter(f => f.branches.includes(branch))
          nextStep.push(newFrame)
        } else {
          nextStep = [newFrame]
        }
        myStory.push(nextStep)
        break
      }
    }

    this.setState({
      myStory,
      currentBranch: branch,
    })
    console.log(this.state)
  }

  render() {
    console.log(this.state)
    return (
      <div className="App">
        <div className="Engine">
          <h2>Orikishi</h2>
          <Story story={ this.state.myStory } name={this.state.ourStory.name} currentBranch={ this.state.currentBranch} setCurrentBranch={this.setCurrentBranch} rewind={this.rewind} addFollowUp={this.addFollowUp} />
        </div>
      </div>
    );
  }
}

class Story extends Component {
  render() {
    const steps = this.props.story.map((s, i) => <Step step={s} key={i} currentBranch={this.props.currentBranch} setCurrentBranch={this.props.setCurrentBranch} last={i === this.props.story.length - 1} rewind={this.props.rewind} addFollowUp={this.props.addFollowUp} />)
    return (
      <div className="Story">
        <h3>{ this.props.name }</h3>
        { steps }
      </div>
    )
  }
}

class Step extends Component {
  render() {
    const frames = this.props.step.map((f, i) => <Frame frame={f} key={i} currentBranch={this.props.currentBranch} addFollowUp={this.props.addFollowUp} onClick={this.props.last ? this.props.setCurrentBranch : this.props.rewind} />)

    return (
      <div className="Step">
        { frames }
      </div>
    )
  }
}

class Frame extends Component {
  render() {
    const frame = this.props.frame
    const branch = frame.branches[1] || frame.branches[0]
    let text

    return (
      <div className="Frame">
        <div onClick={() => this.props.onClick(branch, frame)}>
          <img src={frame.img} alt=""/>
          <p>{frame.text}</p>
        </div>
        <p>Continuer cette histoire</p>
        <form onSubmit={event => {
          event.preventDefault(); this.props.addFollowUp(frame.id, { text }, this)}
        }>
          <input ref="textInput" type="text" placeholder="Votre texte ici" onChange={event => text = event.target.value}/>
          <button type="submit">Creer</button>
        </form>
      </div>
    )
  }
}

export default OrikishiEngine;

