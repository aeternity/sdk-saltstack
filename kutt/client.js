module.exports = {
  /*
    Invisible reCaptcha site key
    Create one in https://www.google.com/recaptcha/intro/
  */
  RECAPTCHA_SITE_KEY: '{{ salt['pillar.get']('kutt:client') }}',

  // Google analytics tracking ID
  GOOGLE_ANALYTICS_ID: '',

  // Report email address
  REPORT_EMAIL: ''
};
