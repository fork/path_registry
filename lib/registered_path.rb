class RegisteredPath < ActiveRecord::Base

  belongs_to :provider, :polymorphic => true

  def has_user?
    PathRegistry.users.any? { |u| u.exists? u.path_registry.foreign_key => id }
  end

  def to_s
    path
  end

  validates_uniqueness_of :provider_id, :scope => :provider_type
  validates_associated :provider

  named_scope :scopeless
  named_scope :have_scope, lambda { |scope|
    { :conditions => {:scope => scope} }
  }

  after_update   { |r| PathRegistry.notify :update, self }
  after_destroy  { |r| PathRegistry.notify :destroy, self }

  protected
  def assign_scope
    klass = provider.class
    self.scope = klass.path_registry.scope provider
  end
  before_validation :assign_scope
  def assign_label
    klass = provider.class
    self.label = klass.path_registry.label provider
  end
  before_validation :assign_label
  def assign_path
    klass = provider.class
    self.path = klass.path_registry.path provider
  end
  before_validation :assign_path

end
