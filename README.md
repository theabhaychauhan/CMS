<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>API Documentation</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 20px;
    }

    h1, h2, h3 {
      color: #333;
    }

    code {
      background-color: #f4f4f4;
      padding: 2px 4px;
      border-radius: 4px;
      font-family: monospace;
    }

    pre {
      background-color: #f8f8f8;
      border: 1px solid #ddd;
      padding: 10px;
      border-radius: 4px;
    }

    .important {
      font-weight: bold;
    }
  </style>
</head>
<body>

<h1>API Documentation</h1>

<h2>Signup - First user will be the admin</h2>
<pre>
<code>
curl --location --request POST 'http://127.0.0.1:3000/signup?name=Abhay%20Chauhan&amp;username=theabhaychauhan&amp;email=ch.abhay%40yahoo.com&amp;password=PASSWORD'
</code>
</pre>

<h2>Login</h2>
<pre>
<code>
curl --location --request POST 'http://127.0.0.1:3000/auth/login?email=ch.abhay%40yahoo.com&amp;password=PASSWORD'
</code>
</pre>

<h2>Administrators</h2>
<p class="important">Get users</p>
<pre>
<code>
curl --location 'http://127.0.0.1:3000/admin/users' \
--header 'Authorization: Bearer TOKEN_OF_AN_ADMIN'
</code>
</pre>

<p class="important">Create user from administrator</p>
<pre>
<code>
curl --location --request POST 'http://127.0.0.1:3000/admin/create_user?email=abhay%40gmail.com&amp;password=12345678&amp;username=theabhayc' \
--header 'Authorization: Bearer TOKEN_OF_AN_ADMIN'
</code>
</pre>

<p class="important">Delete user</p>
<pre>
<code>
curl --location --request DELETE 'http://127.0.0.1:3000/admin/delete_user?email=abhay%40gmail.com' \
--header 'Authorization: Bearer TOKEN_OF_AN_ADMIN'
</code>
</pre>

<h2>Managers</h2>
<pre>
<code>
curl --location 'http://127.0.0.1:3000/manager/users' \
--header 'Authorization: Bearer TOKEN_OF_A_MANAGER'
</code>
</pre>

</body>
</html>
