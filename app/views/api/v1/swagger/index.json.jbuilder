json.swagger "2.0"
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
json.basePath "/api/v1"
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
  },
  {
    name:"Animes",
    description:"List all animes"
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
          type: "string",
          format: "password"
        },
        {
          in: "formData",
          name: "grant_type",
          description: "type user authentication",
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
  },
  "/animes":{
    "get":{
      "tags": [
        "Animes"
      ],
      "summary": "Animes",
      "description": "Return all animes",
      "produces": [
        "application/json"
      ],
      "parameters": [
        {
          in: "query",
          name: "page",
          description: "",
          required: false,
          type: "integer"
        },
        {
          in: "query",
          name: "per_page",
          description: "",
          required: false,
          type: "integer"
        }
      ],
      "responses": {
        "200": {
          "description": "successful operation",
        }
      }
    },
    "post":{
      "tags": [
        "Animes"
      ],
      "summary": "Create a New Anime",
      "description": "",
      "produces": [
        "application/json"
      ],
      "parameters": [
        {
          in: "formData",
          name: "name",
          description: "name for anime",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "synopsis",
          description: "synopsis for anime",
          required: true,
          type: "string"
        },
        {
          in: "formData",
          name: "sessions",
          description: "number sessions for anime",
          required: true,
          type: "integer"
        },
        {
          in: "formData",
          name: "episodes",
          description: "number episodes for anime",
          required: true,
          type: "integer"
        },
        {
          in: "formData",
          name: "cover",
          description: "cover image for anime",
          required: true,
          type: "file"
        },
        {
          in: "formData",
          name: "tags[0][name]",
          description: "name for tag2",
          required: false,
          type: "string"
        },
        {
          in: "formData",
          name: "tags[1][name]",
          description: "name for tag2",
          required: false,
          type: "string"
        },
      ],
      "responses": {
        "200": {
          "description": "successful operation",
        },
        "401": {
          "description": "Unauthorized for request",
        }
      },
      "security": [
        {
          "api_key": []
        }
      ]
    }
  },
  "/animes/{id}":{
    "put":{
      "tags": [
        "Animes"
      ],
      "summary": "Create a New Anime",
      "description": "",
      "produces": [
        "application/json"
      ],
      "parameters": [
        {
          in: "path",
          name: "id",
          description: "anime id",
          required: true,
          type: "integer"
        },
        {
          in: "formData",
          name: "name",
          description: "name for anime",
          required: false,
          type: "string"
        },
        {
          in: "formData",
          name: "synopsis",
          description: "synopsis for anime",
          required: false,
          type: "string"
        },
        {
          in: "formData",
          name: "sessions",
          description: "number sessions for anime",
          required: false,
          type: "integer"
        },
        {
          in: "formData",
          name: "episodes",
          description: "number episodes for anime",
          required: false,
          type: "integer"
        },
        {
          in: "formData",
          name: "cover",
          description: "cover image for anime",
          required: false,
          type: "file"
        },
        {
          in: "formData",
          name: "tags[0][name]",
          description: "name for tag2",
          required: false,
          type: "string"
        },
        {
          in: "formData",
          name: "tags[1][name]",
          description: "name for tag2",
          required: false,
          type: "string"
        },
      ],
      "responses": {
        "200": {
          "description": "successful operation",
        },
        "401": {
          "description": "Unauthorized for request",
        }
      },
      "security": [
        {
          "api_key": []
        }
      ]
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
