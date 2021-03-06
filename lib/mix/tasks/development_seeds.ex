defmodule Mix.Tasks.DevelopmentSeeds do
  use Mix.Task
  import Community.Factory

  @shortdoc "Insert the seeds for development"

  def run(_args) do
    Mix.Task.run "ecto.drop", []
    Mix.Task.run "ecto.create", []
    Mix.Task.run "ecto.migrate", []
    Mix.Task.run "app.start", []

    approve_member(%{
      name: "Sam Seaborn",
      title: "Freelance",
      twitter_handle: "samsconstruction",
    })
    approve_member(%{
      name: "Michelangelo",
      title: "UX Engineer",
      dribbble_username: "Mikey",
      available_for_hire: true,
    })
    approve_member(%{
      name: "Scott Summers",
      title: "Designer at Cyclops Shades",
    })
    approve_member(%{
      name: "Wade Wilson",
      title: "Professional Lion Wrangler",
      available_for_hire: true,
    })
    approve_member(%{
      name: "Bruce Banner",
      title: "Cat Herder",
    })

    for title <- titles() do
      insert(
        :job,
        approved: true,
        company: Enum.random(companies()),
        title: "#{title}"
      )
    end

    insert(:job, title: "Awsesome Designer")
    insert(:job, title: "Rockstar")
  end

  def titles do
    [
      "Lead Designer",
      "Design Ninja",
      "Junior Designer",
      "Digital Designer",
      "Product Designer"
    ]
  end

  def companies do
    [
      "thoughtbot",
      "Vista",
      "Microsoft",
      "Citrix",
      "WebAssign",
      "BigLeap",
      "EA",
      "Big Corp",
    ]
  end

  def approve_member(attributes) do
    build(:member, attributes) |> approve |> insert
  end
end
