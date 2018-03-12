json.swagger "3.0"
json.info do
  json.description "Documetation for API Portal Anime"
  json.version "1.0.0"
  json.title "Portal Anime API Documentation"
  json.contact do
    json.email "alfa0015.rafael@gmail.com"
  end
  json.license do
    json.name ""
    json.url ""
  end
end
json.host "#{request.host_with_port}/api"
json.basePath "/v1"
json.schemes [
  "http"
]
json.tags [
  {
    name:"apidocs",
    description:"Show json view documetation swagger"
  },
  {
    name:"Authentication",
    description:"Authentication for user if is success return token"
  },
  {
    name:"Registration",
    description:"Registration new user"
  }
]
swagger = {
  "/apidocs":{
    "get":{
      "tags": [
        "apidocs"
      ],
      "summary": "Returns configuration swagger",
      "description": "Returns a map of status codes to quantities",
      "produces": [
        "application/json"
      ],
      "parameters": [],
      "responses": {
        "200": {
          "description": "successful operation",
        }
      }
    }
  },
  "/oauth/token":{
    "post":{
      "tags": [
        "Authentication"
      ],
      "summary": "Returns token if request is success",
      "description": "Returns token",
      "produces": [
        "application/json"
      ],
      "parameters": [
        {
          in: "formData",
          name: "email",
          description: "email user for authentication",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "password",
          description: "password user for authentication",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "grant_type",
          description: "email user for authentication",
          required: true,
          type: "string",
          enum:["password"]
        }
      ],
      "responses": {
        "200": {
          "description": "successful operation",
        },
        "401": {
          "description": "Unauthorized for request",
        }
      }
    }
  },
  "/users":{
    "post":{
      "tags": [
        "Registration"
      ],
      "summary": "Create new user",
      "description": "",
      "produces": [
        "application/json"
      ],
      "parameters": [
        {
          in: "formData",
          name: "user[email]",
          description: "email user",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "user[username]",
          description: "email user",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "user[password]",
          description: "password user for authentication",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "user[password_confirmation]",
          description: "password confirmation user for authentication",
          required: true,
          type: "string"
        }
      ],
      "responses": {
        "200": {
          "description": "successful operation",
        },
        "422": {
          "description": "impossible procces request",
        }
      }
    }
  }
}
json.paths swagger
json.securityDefinitions do
  json.api_key do
    json.type "apiKey"
    json.name "Authorization"
    json.in "header"
  end
end
