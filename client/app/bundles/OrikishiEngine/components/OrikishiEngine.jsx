import PropTypes from 'prop-types'
import React, { Component } from 'react'

class OrikishiEngine extends Component {
  constructor(props, _railsContext) {
    super(props)
    this.state = {
      ourStory: props.story,
      myStory: [],
      currentBranch: 1,
      lastStep: 0,
    }

    this.setCurrentBranch = this.setCurrentBranch.bind(this)
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
      myStory.push(currentFrames.filter(f => f.branches.includes(newBranch)))
      if (currentFrames.length > 1) {
        break
      }
    }
    this.setState({ myStory })
  }

  render() {
    return (
      <div className="App">
        <div className="Engine">
          <h2>Orikishi</h2>
          <Story story={ this.state.myStory } name={this.state.ourStory.name} currentBranch={ this.state.currentBranch} setCurrentBranch={this.setCurrentBranch} />
        </div>
      </div>
    );
  }
}

class Story extends Component {
  render() {
    const steps = this.props.story.map((s, i) => <Step step={s} key={i} currentBranch={this.props.currentBranch} setCurrentBranch={this.props.setCurrentBranch} last={i === this.props.story.length - 1} />)
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
    const frames = this.props.step.map((f, i) => <Frame frame={f} key={i} currentBranch={this.props.currentBranch} setCurrentBranch={this.props.setCurrentBranch} last={this.props.last} />)

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

    const branch = frame.branches.length > 1 ? frame.branches.find(b => b !== this.props.currentBranch) : frame.branches[0]

    const click = () => {
      if (this.props.last) {
        this.props.setCurrentBranch(branch)
      }
    }

    return (
      <div className="Frame" onClick={click}>
        <img src={frame.img} alt=""/>
        <p>{frame.text}</p>
      </div>
    )
  }
}

export default OrikishiEngine;

