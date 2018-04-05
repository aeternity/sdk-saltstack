module.exports = {
  PORT: 3000,

  /* The domain that this website is on */
  DEFAULT_DOMAIN: 'aet.li',

  /* Neo4j database credential details */
  DB_URI: 'bolt://neo4j',
  DB_USERNAME: 'neo4j',
  DB_PASSWORD: 'neo4j',

  /* A passphrase to encrypt JWT. Use a long and secure key. */
  JWT_SECRET: 'RegeifDaudimsoitBuktaqueshurjObWoroudjebteinzyefJinEng1josper',

  /*
    Invisible reCaptcha secret key
    Create one in https://www.google.com/recaptcha/intro/
  */
  RECAPTCHA_SECRET_KEY: '{{ salt['pillar.get']('kutt:server') }}',

  /* 
    Google Cloud API to prevent from users from submitting malware URLs.
    Get it from https://developers.google.com/safe-browsing/v4/get-started
  */
  GOOGLE_SAFE_BROWSING_KEY: '{{ salt['pillar.get']('kutt:safe-browsing') }}',

  /*
    Your email host details to use to send verification emails.
    More info on http://nodemailer.com/
  */
  MAIL_HOST: '',
  MAIL_PORT: 587,
  MAIL_SECURE: false,
  MAIL_USER: '',
  MAIL_PASSWORD: ''
};
