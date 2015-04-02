React = require 'react'


Login = React.createClass
  displayName : "Login"

  componentDidMount:->
    @fetchUser()

  getInitialState:->
    console.log("inital state")
    user: null
    loading: false
    error: null

  fetchUser:->
    @setState
      loading: true
      error: null
    request = $.getJSON "/current_user"

    request.done (result)=>
      @setState
        user: result.user
        loading: false


    request.fail (error)=>
      @setState
        loading:false
        error: "Having trouble logging you in"

  render:->
    <div class='login'>
      {@renderError() if @state.error}

      {@renderLoggedIn() if @state.user}
      {@renderLoggedOut() if !@state.user}
      {if @state.loading
        <p>Loading ...</p>
      }
    </div>

  renderLoggedIn:->
    <p>Hello {@state.user.name} <a href='/users/sign_out'>Logout</a></p>


  renderLoggedOut:->
    <p>Login</p>
    <div className='dropdown'>
      <p>Using</p>
      <div className='options'>
        <a href='/users/auth/facebook'>      Facebook</a>
        <a href='/users/auth/google-oauth2'> Google Plus</a>
        <a href='/users/auth/zooniverse' >   Zooniverse</a>
      </div>
    </div>


module.exports = Login
