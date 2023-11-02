Team Members:
Ben Kuhn (bk2782)
Jasmine Lou (yl4386)
Michael Danzi (mjd2266)
Sopho Kevlishvili (sk4698)

Instructions to run and test product

To run product:
1. Please run bundle exec rackup --host 0.0.0.0 --port 3001 
2. Type or copy & paste text into the resume text field
   * We are still working on parsing attachment files, so ignore this part of the view
     for now. This part is not part of our MVP, but it will be fleshed out for iteration
3. Click on 'Upload Resume'
4. Now, Paste your job description into the job description field.
5. Click on the green 'T(ai)lor!' button
6. Once your resume has been T(ai)lored, download your new tailored resume!
   * We are still working on the resume editor button, if you go to that page you 
   should see your tailored resume which you can edit and save changes. Most of our
   time was not spent on this part, ignore bugs as this as it is not part 
   of the MVP. The goal is that users are able to view and edit their newly tailored
  resume to ensure accuracy.
7. Verify that your resume now is better tailored to the job description than it was
   before.
   
To test product:
1. In the Iteration directory, run 'bundle exec cucumber'
2. In the Iteration directory, run 'bundle exec rspec'

Heroku Link: https://pure-river-69411-5cfef20475c9.herokuapp.com/uploaded
only /uploaded works, /editor and /resume do not work. They do work on 
the local servers though.