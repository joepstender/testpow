defmodule TestpowWeb.PowInvitation.MailerView do
  use TestpowWeb, :mailer_view

  def subject(:invitation, _assigns), do: "You've been invited"
end
